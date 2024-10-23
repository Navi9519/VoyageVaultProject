//
//  LocationManager.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    override init() {
       
        super .init()
        
        manager.delegate = self
    }
    
    
}
