//
//  FileDialog.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa

func FileDialog(prompt: String = "Choose a folder") -> URL? {
    let dialog = NSOpenPanel();

    dialog.title                   = "\(prompt) | FaceCropper";
    dialog.showsResizeIndicator    = true
    dialog.showsHiddenFiles        = false
    dialog.allowsMultipleSelection = false
    dialog.canChooseDirectories    = true
    dialog.canChooseFiles          = false

    if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
        let result = dialog.url // Pathname of the file

        if let result = result {
            return result
            
            // path contains the file path e.g
            // /Users/ourcodeworld/Desktop/file.txt
        }
        
    }

    return nil
}
