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

let STATUS_SEARCHING_MESSAGE = "Buscando SENECA..."
let STATUS_SEARCHING_ICON = "NSStatusNone"

// Define helper bundler identifier
let APP_BUNDLER_INDENTIFIER = "co.edu.uniandes.seneca-helper" as CFString

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, PreferencesWindowDelegate, SenecaLoginDelegate {

    // Pointer to the complete menu
    @IBOutlet weak var statusMenu: NSMenu!

    // Pointer to the status text menu item
    @IBOutlet weak var connectionStatusItem: NSMenuItem!
    
    // Define the preferences & about windows
    var preferencesWindow: PreferencesWindow!
    var aboutWindow: AboutWindow!
    
    // Pointer to the status icon on the navbar
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    // Pointer to seneca login controller
    var connectionController: SenecaLoginController!
    
    // Open the about window when about button is pressed
    @IBAction func aboutClicked(_ sender: NSMenuItem) {
        aboutWindow.showWindow(nil)
    }
    
    // Open the preferences window when preferences button is pressed
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    // Close the app when the quit button is pressed
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    // Execute when the application has fully loaded
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Configure the status icon on the navbar
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        // Initialize the preferences & about windows
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        aboutWindow = AboutWindow()
        
        // Initialize connection controller
        connectionController = SenecaLoginController()
        connectionController.delegate = self
        
        // Check if SENECA is current SSID on startup
        checkSeneca()
    }
    
    // Check if seneca is the current SSID
    func checkSeneca() {
        changeStatusToSearching()
        if connectionController.isSenecaCurrentSSID() {
            changeStatusToDisconnected()
        } else {
            changeStatusToUnavailable()
        }
        print("CHECKED SENECA :)")
    }
    
    // Update the preferences values when they are changed
    func preferencesDidUpdate() {
        // Load the persistence unit
        let defaults = UserDefaults.standard
        
        // Configure the autolaunch at login option
        let enabled = defaults.integer(forKey: START) == NSOnState
        SMLoginItemSetEnabled(APP_BUNDLER_INDENTIFIER, enabled)
    }
    
    // Change status text to connected
    func changeStatusToConnected() {
        connectionStatusItem.title = STATUS_CONNECTED_MESSAGE
        connectionStatusItem.image = NSImage(named: STATUS_CONNECTED_ICON)
    }
    
    // Change status text to unavailable
    func changeStatusToUnavailable() {
        connectionStatusItem.title = STATUS_UNAVAILABLE_MESSAGE
        connectionStatusItem.image = NSImage(named: STATUS_UNAVAILABLE_ICON)
    }
    
    // Change status text to disconnected
    func changeStatusToDisconnected() {
        connectionStatusItem.title = STATUS_DISCONNECTED_MESSAGE
        connectionStatusItem.image = NSImage(named: STATUS_DISCONNECTED_ICON)
    }
    
    // Change status text to searching
    func changeStatusToSearching() {
        connectionStatusItem.title = STATUS_SEARCHING_MESSAGE
        connectionStatusItem.image = NSImage(named: STATUS_SEARCHING_ICON)
    }
}
