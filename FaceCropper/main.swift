//
//  main.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa

// Create file dialog and get directory to load photos from
let fileManager = FileManager.default
guard let documentsURL = FileDialog() else {
    print("Folder not chosen")
    throw NSError.init()
}

// Create another file dialog to get directory to save cropped faces to
guard let outputURL = FileDialog(prompt: "Choose an output location") else {
    print("Output folder not chosen")
    throw NSError.init()
}

do {
    // Create an array of files in the first URL
    let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
    
    // For each file in original directory...
    for fileURL in fileURLs {
        // If file is an image...
        if let image = getImage(url: fileURL) {
            // Process the image and get an array of cropped faces
            let faces = processImage(image: image)
            
            // For each face detected, save the face as a new file in the output directory
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
    // There was an issue looking for the files. Haven't run into this, but I think think it'll happen when the documentsURL is invalid (which won't happen when using the file dialog
    print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
}
