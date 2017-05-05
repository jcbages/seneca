import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    
    // Set the delegate to follow the PreferencesWindowDelegate protocol
    var delegate: PreferencesWindowDelegate?

    // Pointer to "start at login" checkbox
    @IBOutlet weak var startAtLoginCheckBox: NSButton!
    
    // Pointer to username textbox
    @IBOutlet weak var accountTextField: NSTextField!
    
    // Pointer to password textbox
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Configure window
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        // Main app persistence unit, here is where saving/loading user credential happens
        let defaults = UserDefaults.standard

        // Retrieve and set the open at login option
        let start = defaults.integer(forKey: START)
        startAtLoginCheckBox.state = start

        // Retrieve and set the defaults username
        let account = defaults.string(forKey: ACCOUNT) ?? BLANK_FIELD_TEXT
        accountTextField.stringValue = account
        
        // Retrieve and set the defaults password
        let password = defaults.string(forKey: PASSWORD) ?? BLANK_FIELD_TEXT
        passwordTextField.stringValue = password
    }
    
    func windowWillClose(_ notification: Notification) {
        // Save the options in the app main persistence unit
        let defaults = UserDefaults.standard
        
        // Save the open at login option from the checkbox
        defaults.setValue(startAtLoginCheckBox.state, forKey: START)
        
        // Save the account text field
        defaults.setValue(accountTextField.stringValue, forKey: ACCOUNT)
        
        // Save the password text field
        defaults.setValue(passwordTextField.stringValue, forKey: PASSWORD)
        
        // Notify an update to the delegate
        delegate?.preferencesDidUpdate()
    }
    
}
