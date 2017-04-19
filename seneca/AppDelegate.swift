//
//  AppDelegate.swift
//  seneca
//
//  Created by Sebastian Camilo Valencia on 4/18/17.
//  Copyright © 2017 Sebastian Camilo Valencia. All rights reserved.
//

import Cocoa

let BLANK_FIELD_TEXT = ""

let SENECA_WEBPAGE = "https://books.google.com.co/"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, PreferencesWindowDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    var preferencesWindow: PreferencesWindow!
    var aboutWindow: AboutWindow!
    
    @IBAction func aboutClicked(_ sender: NSMenuItem) {
        aboutWindow.showWindow(nil)
    }
    
    @IBAction func documentationClicked(_ sender: NSMenuItem) {
        if let url = URL(string: SENECA_WEBPAGE), NSWorkspace.shared().open(url) {}
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        aboutWindow = AboutWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func preferencesDidUpdate() {
        let defaults = UserDefaults.standard
        let account = defaults.string(forKey: "start") ?? BLANK_FIELD_TEXT
        NSLog(account)
    }


}

