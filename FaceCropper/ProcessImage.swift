//
//  ProcessImage.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa

/// Driver function to process an NSImage into an array of cropped CGImages of faces
/// - Parameter image: Image to detect faces in
/// - Returns: Array of cropped images of faces if any were found
func processImage(image: NSImage) -> [CGImage] {
    var imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
    guard let cgImage = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else {
        print("Error converting image to CGImage")
        return []
    }
    
    let cropper = ImageCropper(image: cgImage)
    cropper.processImage()
    return cropper.cropped
}
