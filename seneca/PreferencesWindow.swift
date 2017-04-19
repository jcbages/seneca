//
//  PreferencesWindow.swift
//  seneca
//
//  Created by Sebastian Camilo Valencia on 4/18/17.
//  Copyright © 2017 Sebastian Camilo Valencia. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    
    let DEFAULT_CHECKED = ""
    
    var delegate: PreferencesWindowDelegate?

    @IBOutlet weak var startAtLoginCheckBox: NSButton!
    
    @IBOutlet weak var accountTextField: NSTextField!
    
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBAction func saveClicked(_ sender: NSButton) {
        
        self.close()
    }
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        let defaults = UserDefaults.standard
        
        let account = defaults.string(forKey: "account") ?? BLANK_FIELD_TEXT
        accountTextField.stringValue = account
        
        let password = defaults.string(forKey: "password") ?? BLANK_FIELD_TEXT
        passwordTextField.stringValue = password
    }
    
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        
        defaults.setValue(startAtLoginCheckBox.stringValue, forKey: "start")
        
        defaults.setValue(accountTextField.stringValue, forKey: "account")
        
        defaults.setValue(passwordTextField.stringValue, forKey: "password")
        
        delegate?.preferencesDidUpdate()
    }
    
}
