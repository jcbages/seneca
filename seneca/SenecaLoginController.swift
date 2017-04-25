import Foundation
import CoreWLAN

class SenecaLoginController {
    
    let BASE_URL = "https://wlan.uniandes.edu.co/login.html"
    
    let WIFI_NETWORK_NAME = "SENECA"
    
    func doConnectionPOST() {}

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
                return nil;
            }
        }
        
        return nil;
    }
    
    func isSenecaReacheable() -> Bool {
        
        if let networks = discoverReacheableNetworks() {
            let SSIDs = networks.map {network in network.ssid!}
            return SSIDs.contains(WIFI_NETWORK_NAME)
        }
        
        return false
    }
    
    func isSenecaCurrentSSID() -> Bool {
        if let wifiInterface = CWWiFiClient.shared().interface(), let ssid = wifiInterface.ssid() {
            return ssid == WIFI_NETWORK_NAME
        }
        return false;
    }
    
    func connectedToSeneca() {}
    
    func connectedToInternet() {}
}
