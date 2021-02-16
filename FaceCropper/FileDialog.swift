//
//  FileDialog.swift
//  FaceCropper
//
//  Created by Matthew Geimer on 2/14/21.
//

import Cocoa

/// Helper function to display a file dialog prompt and pick a folder
/// - Parameter prompt: Title for fileDialog. As of MacOS Big Sur, I could not determine if this changed anything
/// - Returns: URL to selected folder if one was selected. Otherwise returns nil.
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
