//
//  ProcessImage.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa

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
