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
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        // Main app persistence unit, here is where saving/loading user credential happens
        let defaults = UserDefaults.standard
        
        // Retrieving and setting the default username
        let account = defaults.string(forKey: "account") ?? BLANK_FIELD_TEXT
        accountTextField.stringValue = account
        
        // Retrieving and setting the default password
        let password = defaults.string(forKey: "password") ?? BLANK_FIELD_TEXT
        passwordTextField.stringValue = password
    }
    
    func windowWillClose(_ notification: Notification) {
        // Save the options in the app main persistence unit
        let defaults = UserDefaults.standard
        
        // Save the open at login option from the checkbox
        defaults.setValue(startAtLoginCheckBox.stringValue, forKey: "start")
        
        // Save the account text field
        defaults.setValue(accountTextField.stringValue, forKey: "account")
        
        // Save the password text field
        defaults.setValue(passwordTextField.stringValue, forKey: "password")
        
        // Notify an update to the delegate
        delegate?.preferencesDidUpdate()
    }
    
}
