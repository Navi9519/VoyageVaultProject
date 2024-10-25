//
//  Country.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import Foundation


struct Country: Codable {
    
    var name: String
    var capital: String
    var cities: [String]
    var currency: String
    var flag: String
}

struct Location: Codable {
    var latitude: Double
    var longitude: Double
}
