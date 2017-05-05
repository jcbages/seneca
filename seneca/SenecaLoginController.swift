import Foundation
import CoreWLAN

protocol SenecaLoginDelegate {
    func checkSeneca()
}

class SenecaLoginController: CWEventDelegate {
    // Set the delegate for this class
    var delegate: SenecaLoginDelegate?

    // URL for connecting to the SENECA network
    let BASE_URL = "https://wlan.uniandes.edu.co/login.html"

    // SENECA network SSID
    let WIFI_NETWORK_NAME = "SENECA"

    // Class initializator
    init() {
        // Init & configure wifi client
        let wifiClient = CWWiFiClient.shared()
        wifiClient.delegate = self
        
        // Register to WiFi events
        do {
            try wifiClient.startMonitoringEvent(with: CWEventType.ssidDidChange)
        } catch {
            print("An error occured while registering events D:")
            print(error)
        }
    }

    // Class deinitializator
    deinit {
        // Unregister for every WiFi event
        do {
            try CWWiFiClient.shared().stopMonitoringAllEvents()
        } catch {
            print("An error occured while deregistering events D:")
        }
    }

    // Check if SENECA is the current connected network
    func isSenecaCurrentSSID() -> Bool {
        if let wifiInterface = CWWiFiClient.shared().interface(), let ssid = wifiInterface.ssid() {
            return ssid == WIFI_NETWORK_NAME
        }
        return false;
    }
    
    // Handle SSID change in WiFi
    func ssidDidChangeForWiFiInterface(withName interfaceName: String) {
        delegate?.checkSeneca()
    }
}
