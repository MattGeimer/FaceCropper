//
//  FileIO.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa

func getURL(name: String, fileExtension: String) -> URL {
    let documentDirectoryURL = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = documentDirectoryURL.appendingPathComponent(name).appendingPathExtension(fileExtension)
    return fileURL
}

func saveData(data: Data, url: URL) {
    do {
        try data.write(to: url)
    } catch let error as NSError {
        print("Failed to write to URL. Error: \(error)")
    }
}

func readData(url: URL) -> Data? {
    do {
        let data = try Data(contentsOf: url)
        return data
    } catch let error as NSError {
        print("Failed to read from URL. Error: \(error)")
    }
    
    return nil
}

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

func saveImage(image: NSImage, url: URL) {
    if let data = image.tiffRepresentation {
        saveData(data: data, url: url)
    }
}

func saveImage(image: CGImage, url: URL) {
    let nsImage = NSImage(cgImage: image, size: .zero)
    saveImage(image: nsImage, url: url)
}
