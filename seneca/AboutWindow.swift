//
//  AboutWindow.swift
//  seneca
//
//  Created by Sebastian Camilo Valencia on 4/18/17.
//  Copyright © 2017 Sebastian Camilo Valencia. All rights reserved.
//

import Cocoa

let APP_VERSION = "1.0.0"

let NAME_LABEL_TEXT = "seneca"

class AboutWindow: NSWindowController {

    @IBOutlet weak var logoIcon: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var versionLabel: NSTextField!
    
    override var windowNibName : String! {
        return "AboutWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        self.logoIcon.image = NSImage(named: "logo")
        
        self.nameLabel.font = NSFont(name: "Helvetica Neue Light", size: 14)
        self.nameLabel.font = NSFont.boldSystemFont(ofSize: 14.0)
        
        self.versionLabel.stringValue = "Version \(APP_VERSION)"
        self.versionLabel.font = NSFont(name: "Helvetica Neue Light", size: 10)
    }
    
}
