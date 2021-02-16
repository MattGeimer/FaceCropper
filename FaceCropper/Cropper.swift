//
//  Cropper.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa
import Vision

/// Takes in an original image, processes said image, and allows the retrieval of images containing faces detected by Vision framework
class ImageCropper {
    /// The original image to process
    var original: CGImage
    
    /// An array of images containing faces detected in the original image
    var cropped: [CGImage] = []
    
    /// Initializer
    /// - Parameter image: image to process
    init(image: CGImage) {
        original = image
    }
    
    /// In order to save time by not initializing/tearing down this object, you can call setImage to reset the ImageCropper as if the newImage was provided in the constructor
    /// - Parameter newImage: New Image to save as original
    func setImage(_ newImage: CGImage) {
        self.original = newImage
        self.cropped = []
    }
    
    /// Process the image
    func processImage() {
        // Define request for Vision framework with callback function
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            // If no faces were detected, print message along with error passed from Vision
            if let error = error {
                print("Failed to detect faces: \(error)")
                return
            }
            
            // For each result returned by Vision...
            request.results?.forEach({ (result) in
                // Ensure the result is a face being observed
                guard let faceObservation = result as? VNFaceObservation else {
                    return
                }
                
                // Using data from face observation, determine coordinates in the image with which the face can be cropped to
                let x = CGFloat(self.original.width) * faceObservation.boundingBox.origin.x
                let height = CGFloat(self.original.height) * faceObservation.boundingBox.height
                let y = CGFloat(self.original.height) * (1 - faceObservation.boundingBox.origin.y) - height
                let width = CGFloat(self.original.width) * faceObservation.boundingBox.width
                
                // Crop original image to the dimensions above, then add it to the output array of cropped images
                if let croppedImage = self.original.cropping(to: CGRect(x: x, y: y, width: width, height: height)) {
                    self.cropped.append(croppedImage)
                }
            })
        }

        // Declare Vision framework handler
        let handler = VNImageRequestHandler(cgImage: original, options: [:])

        do {
            // Synchronously call the handler so that when the call to processImage() is done, the calling code can access cropped array and guarantee there's data there
            try handler.perform([request])
        } catch let error {
            // Handler request failed, print out error
            print("Failed request: ", error)
        }
    }
}
