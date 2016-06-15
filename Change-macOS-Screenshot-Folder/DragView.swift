//
//  DragView.swift
//  Change-macOS-Screenshot-Folder
//
//  Created by Santiago Martín on 15/6/16.
//  Copyright © 2016 Santiago Martín. All rights reserved.
//

import Cocoa

class DragView: NSView {
    
    var filePath: String?
    let expectedExt = ""
    @IBOutlet weak var textFielPath: NSTextField!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        
        registerForDraggedTypes([NSFilenamesPboardType, NSURLPboardType])
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
        if let pasteboard = sender.draggingPasteboard().propertyListForType("NSFilenamesPboardType") as? NSArray {
            if let path = pasteboard[0] as? String {
                let ext = NSURL(fileURLWithPath: path).pathExtension
                if ext == expectedExt {
                    return NSDragOperation.Copy
                }
            }
        }
        return NSDragOperation.None
    }
    
    override func draggingExited(sender: NSDraggingInfo?) {
    }
    
    override func draggingEnded(sender: NSDraggingInfo?) {
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        if let pasteboard = sender.draggingPasteboard().propertyListForType("NSFilenamesPboardType") as? NSArray {
            if let path = pasteboard[0] as? String {
                
                self.filePath = path
                self.textFielPath.stringValue = self.filePath!
                
                return true
            }
        }
        return false
    }
    
}
