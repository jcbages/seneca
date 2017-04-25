import Cocoa

let APP_VERSION = "1.0.0"

let NAME_LABEL_TEXT = "seneca"

let CONTACT_EMAIL = "jc.bages10@uniandes.edu.co"

let SUPPORT_MESSAGE = "Si tienes algúna duda, escríbenos a alguno de estos correos"

let SUPPORT_EMAIL = "sc.valencia606@uniandes.edu.co"

let REPOSITORY_MESSAGE = "Si nos quieres apoyar, entra a"

let REPOSITORY_LINK = "https://github.com/jcbages/seneca"

let MAIN_FONT = "Helvetica Neue Light"

class AboutWindow: NSWindowController {

    /*
     * The UI components related to this particular view, specified 
     * to handle them in this controller
    */
    
    @IBOutlet weak var logoIcon: NSImageView!

    @IBOutlet weak var nameLabel: NSTextField!
    
    @IBOutlet weak var versionLabel: NSTextField!
    
    @IBOutlet weak var contactEmailLabel: NSTextField!
    
    @IBOutlet weak var emailLabel: NSTextField!
    
    @IBOutlet weak var supportEmailLabel: NSTextField!
    
    @IBOutlet weak var supportRepositoryLabel: NSTextField!
    
    @IBOutlet weak var repositoryLabel: NSTextField!
    
    
    override var windowNibName : String! {
        return "AboutWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        // Handling the logo image
        self.logoIcon.image = NSImage(named: "logo")
        
        // Handling the project name label
        self.nameLabel.font = NSFont(name: MAIN_FONT, size: 16)
        
        // Handling the project version label
        self.versionLabel.stringValue = "Versión \(APP_VERSION)"
        self.versionLabel.font = NSFont(name: MAIN_FONT, size: 10)
        
        self.contactEmailLabel.stringValue = SUPPORT_MESSAGE
        self.contactEmailLabel.font = NSFont(name: MAIN_FONT, size: 12)
        
        self.emailLabel.stringValue = CONTACT_EMAIL
        self.emailLabel.font = NSFont(name: MAIN_FONT, size: 12)
        
        self.supportEmailLabel.stringValue = SUPPORT_EMAIL
        self.supportEmailLabel.font = NSFont(name: MAIN_FONT, size: 12)
        
        self.supportRepositoryLabel.stringValue = REPOSITORY_MESSAGE
        self.supportRepositoryLabel.font = NSFont(name: MAIN_FONT, size: 12)
        
        self.repositoryLabel.stringValue = REPOSITORY_LINK
        self.repositoryLabel.font = NSFont(name: MAIN_FONT, size: 12)
    }
    
}
