//
//  ViewController.swift
//  Change-macOS-Screenshot-Folder
//
//  Created by Santiago Martín on 15/6/16.
//  Copyright © 2016 Santiago Martín. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var openButton: NSButton!
    @IBOutlet weak var pathTextField: NSTextField!
    @IBOutlet weak var setFolderButton: NSButton!
    var path = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        pathTextField.editable = false
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()

        view.window!.title = "Change-macOS-Screenshot-Folder"
    }


    @IBAction func openButtonClick(sender: NSButton) {
        openDialog()
    }
    
    private func openDialog(){
        
        let dialog: NSOpenPanel = NSOpenPanel()
        
        dialog.canChooseFiles = false
        dialog.canChooseDirectories = true
        dialog.title = "Select the folder"
        
        if (dialog.runModal() == NSModalResponseOK) {
            path = (dialog.URL?.path)!
            pathTextField.stringValue = path
        }
        
    }

    @IBAction func setFolder(sender: NSButton) {
        
        var task = NSTask()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["defaults", "write",
            "com.apple.screencapture", "location",
            path.precomposedStringWithCanonicalMapping]
        task.launch()
        task.waitUntilExit()
        
        task = NSTask()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["killall", "SystemUIServer"]
        task.launch()
        task.waitUntilExit()
        
    }
}

