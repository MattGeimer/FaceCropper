//
//  FileIO.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa

/// Driver function to save data to url, otherwise prints out error
/// - Parameters:
///   - data: data to save
///   - url: url to save data at
func saveData(data: Data, url: URL) {
    do {
        try data.write(to: url)
    } catch let error as NSError {
        print("Failed to write to URL. Error: \(error)")
    }
}

/// Driver function to read data from URL, otherwise prints error.
/// - Parameter url: URL to read from
/// - Returns: data if any was found at URL provided. Otherwise nil.
func readData(url: URL) -> Data? {
    do {
        let data = try Data(contentsOf: url)
        return data
    } catch let error as NSError {
        print("Failed to read from URL. Error: \(error)")
    }
    
    return nil
}

/// Driver functino to automatically convert data read from a file to an image
/// - Parameter url: URL to read from
/// - Returns: an image if data could be found and converted to an image
func getImage(url: URL) -> NSImage? {
    do {
        if let data = readData(url: url) {
            if let image = NSImage(data: data) {
                return image
            }
        }
        
        return nil
    }
}

/// Driver function to automatically convert image to data and save it to a file
/// - Parameters:
///   - image: NSImage to save
///   - url: URL to save image to
func saveImage(image: NSImage, url: URL) {
    if let data = image.tiffRepresentation {
        saveData(data: data, url: url)
    }
}

/// Helper function to convert CGImage to NSImage and subsequently save to given URL
/// - Parameters:
///   - image: image to save as CGImage
///   - url: URL to save image to
func saveImage(image: CGImage, url: URL) {
    let nsImage = NSImage(cgImage: image, size: .zero)
    saveImage(image: nsImage, url: url)
}
