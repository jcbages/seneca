import Cocoa
import ServiceManagement

// Blank text field default string
let BLANK_FIELD_TEXT = ""

// User preferences keys
let START = "start"
let ACCOUNT = "account"
let PASSWORD = "password"

// Status message & icon foreach possible state
let STATUS_CONNECTED_MESSAGE = "Estás conectado"
let STATUS_CONNECTED_ICON = "NSStatusAvailable"

let STATUS_DISCONNECTED_MESSAGE = "Estás desconectado"
let STATUS_DISCONNECTED_ICON = "NSStatusUnavailable"

let STATUS_UNAVAILABLE_MESSAGE = "No estás en SENECA"
let STATUS_UNAVAILABLE_ICON = "NSStatusNone"

// Define helper bundler identifier
let APP_BUNDLER_INDENTIFIER = "co.edu.uniandes.seneca-helper" as CFString

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
        
        print(connectionController.recheableSeneca())
    }
    
    func preferencesDidUpdate() {
        // Load the persistence unit
        let defaults = UserDefaults.standard
        
        // Configure the autolaunch at login option
        let enabled = defaults.integer(forKey: START) == NSOnState
        SMLoginItemSetEnabled(APP_BUNDLER_INDENTIFIER, enabled)
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

