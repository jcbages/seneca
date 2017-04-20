//
//  SENECALoginController.swift
//  seneca
//
//  Created by Sebastian Camilo Valencia on 4/18/17.
//  Copyright © 2017 Sebastian Camilo Valencia. All rights reserved.
//

import Foundation
import CoreWLAN

class SENECALoginController {
    
    let BASE_URL = "https://wlan.uniandes.edu.co/login.html"
    
    func doConnectionPOST() {
    }
    
    
}

class Discovery {
    
    var currentInterface: CWInterface
    var interfacesNames: [String] = []
    var networks: Set<CWNetwork> = []
    
    // Failable init using default interface. Fails if no connection detected
    init?() {
        if let defaultInterface = CWWiFiClient.shared().interface(),
            let name = defaultInterface.interfaceName {
            self.currentInterface = defaultInterface
            self.interfacesNames.append(name)
            self.findNetworks()
        } else {
            return nil
        }
    }
    
    // Fetch detectable WIFI networks
    func findNetworks() {
        do {
            self.networks = try currentInterface.scanForNetworks(withSSID: nil)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
