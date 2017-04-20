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

let STATUS_CONNECTED_MESSAGE = "Estás conectado"
let STATUS_CONNECTED_ICON = "NSStatusAvailable"

let STATUS_DISCONNECTED_MESSAGE = "Estás desconectado"
let STATUS_DISCONNECTED_ICON = "NSStatusUnavailable"

let STATUS_UNAVAILABLE_MESSAGE = "No estás en SENECA"
let STATUS_UNAVAILABLE_ICON = "NSStatusNone"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, PreferencesWindowDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    var preferencesWindow: PreferencesWindow!
    var aboutWindow: AboutWindow!
    
    @IBOutlet weak var connectionStatusItem: NSMenuItem!
    
    @IBAction func connectionStatusItemClicked(_ sender: NSMenuItem) {
    }
    
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
        
        // Default status at startup
        changeStatusToDisconnected()
        
        let connectionController = SENECALoginController()
        
        print(connectionController.isSenecaReacheable())
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func preferencesDidUpdate() {
        let defaults = UserDefaults.standard
        let account = defaults.string(forKey: "start") ?? BLANK_FIELD_TEXT
        NSLog(account)
    }
    
    func changeStatusToConnected() {
        connectionStatusItem.title = STATUS_CONNECTED_MESSAGE
        connectionStatusItem.image = NSImage(named: STATUS_CONNECTED_ICON)
    }
    
    func changeSatusToUnavailable() {
        connectionStatusItem.title = STATUS_UNAVAILABLE_MESSAGE
        connectionStatusItem.image = NSImage(named: STATUS_UNAVAILABLE_ICON)
    }
    
    func changeStatusToDisconnected() {
        connectionStatusItem.title = STATUS_DISCONNECTED_MESSAGE
        connectionStatusItem.image = NSImage(named: STATUS_DISCONNECTED_ICON)
    }
}
