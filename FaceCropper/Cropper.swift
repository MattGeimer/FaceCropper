//
//  Cropper.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa
import Vision

class ImageCropper {
    var original: CGImage
    var cropped: [CGImage] = []
    
    init(image: CGImage) {
        original = image
    }
    
    func setImage(_ newImage: CGImage) {
        self.original = newImage
        self.cropped = []
    }

    func processImage() {
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            if let error = error {
                print("Failed to detect faces: \(error)")
                return
            }
            
            request.results?.forEach({ (result) in
                guard let faceObservation = result as? VNFaceObservation else {
                    return
                }
                
                let x = CGFloat(self.original.width) * faceObservation.boundingBox.origin.x
                let height = CGFloat(self.original.height) * faceObservation.boundingBox.height
                let y = CGFloat(self.original.height) * (1 - faceObservation.boundingBox.origin.y) - height
                let width = CGFloat(self.original.width) * faceObservation.boundingBox.width
                
                
                if let croppedImage = self.original.cropping(to: CGRect(x: x, y: y, width: width, height: height)) {
                    self.cropped.append(croppedImage)
                }
            })
        }

        let handler = VNImageRequestHandler(cgImage: original, options: [:])

        do {
            try handler.perform([request])
        } catch let error {
            print("Failed request: ", error)
        }
    }
}
