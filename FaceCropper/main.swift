//
//  main.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa

let fileManager = FileManager.default
guard let documentsURL = FileDialog() else {
    print("Folder not chosen")
    throw NSError.init()
}

guard let outputURL = FileDialog(prompt: "Choose an output location") else {
    print("Output folder not chosen")
    throw NSError.init()
}

// MARK: Get all files in a directory

do {
    let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
    for fileURL in fileURLs {
        if let image = getImage(url: fileURL) {
            let faces = processImage(image: image)
            
            for i in 0 ..< faces.count {
                let fileName = fileURL.deletingPathExtension().lastPathComponent
                let outputFileURL = outputURL
                    .appendingPathComponent("\(fileName)_face\(i)")
                    .appendingPathExtension("jpeg")
                saveImage(image: faces[i], url: outputFileURL)
            }
        }
    }
} catch {
    print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
}
