import Foundation
import CoreWLAN

class SenecaLoginController {
    
    let BASE_URL = "https://wlan.uniandes.edu.co/login.html"
    
    let WIFI_NETWORK_NAME = "SENECA"
    
    func doConnectionPOST() {}
    
    func isSenecaCurrentSSID() -> Bool {
        if let wifiInterface = CWWiFiClient.shared().interface(), let ssid = wifiInterface.ssid() {
            return ssid == WIFI_NETWORK_NAME
        }
        return false;
    }
    
    func connectedToSeneca() {}
    
    func connectedToInternet() {}
}
