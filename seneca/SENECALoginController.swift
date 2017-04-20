import Foundation
import CoreWLAN

class SENECALoginController {
    
    let BASE_URL = "https://wlan.uniandes.edu.co/login.html"
    
    let WIFI_NETWORK_NAME = "SENECA"
    
    func doConnectionPOST() {
    }
    
    func discoverReacheableNetworks() -> Set<CWNetwork>? {
        var currentInterface: CWInterface
        var interfacesNames: [String] = []
        var networks: Set<CWNetwork> = []
        
        // Failable init using default interface. Fails if no connection detected
        if let defaultInterface = CWWiFiClient.shared().interface(),
            let name = defaultInterface.interfaceName {
            currentInterface = defaultInterface
            interfacesNames.append(name)
            // Fetch reacheable WiFi networks
            do {
                networks = try currentInterface.scanForNetworks(withSSID: nil)
                return networks
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
        } else {
            print("No availlable resources")
        }
        
        return nil;
    }
    
    func recheableSeneca() -> Bool {
        
        for network in discoverReacheableNetworks()! {
            let currentSSID = network.ssid!
            print(currentSSID)
            if(currentSSID == WIFI_NETWORK_NAME) {
                return true
            }
        }
        
        return false
    }
    
    func connectedToSeneca() {
        
    }
    
    func connectedToInternet() {
        
    }
    
    
}
