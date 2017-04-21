import Cocoa

let APP_VERSION = "1.0.0"

let NAME_LABEL_TEXT = "seneca"

let CONTACT_EMAIL = "sc.valencia606@uniandes.edu.co"

let REPOSITORY_LINK = "https://github.com/jcbages/seneca"

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
        self.nameLabel.font = NSFont(name: "Helvetica Neue Light", size: 14)
        self.nameLabel.font = NSFont.boldSystemFont(ofSize: 14.0)
        
        // Handling the project version label
        self.versionLabel.stringValue = "Versión \(APP_VERSION)"
        self.versionLabel.font = NSFont(name: "Helvetica Neue Light", size: 10)
        
        self.contactEmailLabel.stringValue = "Si tienes algúna duda, escríbenos al correo"
        self.contactEmailLabel.font = NSFont(name: "Helvetica Neue Light", size: 10)
        
        self.emailLabel.stringValue = CONTACT_EMAIL
        self.emailLabel.font = NSFont(name: "Helvetica Neue Light", size: 10)
        
        self.supportRepositoryLabel.stringValue = "Si nos quieres apoyar, entra a"
        self.supportRepositoryLabel.font = NSFont(name: "Helvetica Neue Light", size: 10)
        
        self.repositoryLabel.stringValue = REPOSITORY_LINK
        self.repositoryLabel.font = NSFont(name: "Helvetica Neue Light", size: 10)
    }
    
}
