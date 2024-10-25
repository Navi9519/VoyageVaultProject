//
//  Country.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import Foundation
import CoreLocation


struct Country: Identifiable, Codable {
    
    // id is needed when working with Identifiable
    var id = UUID().uuidString
    
    var name: String
    var capital: String
    var cities: [String]
    var currency: String
    var flag: String
    var location: Location
}

struct Location: Codable {
    var latitude: Double
    var longitude: Double
}
