//
//  ApiModel.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-24.
//

import Foundation
import FirebaseFirestore


struct CountryData: Codable {
    var name: String
    var unicodeFlag: String

}


struct CountryApi: Codable {
    var error: Bool
    var msg: String
    var data: CountryData
}


struct CountryRequest: Encodable {
    let iso2: String
}

struct CityData: Codable, Identifiable {
    
    var id: String?
    var name: String
    var latitude: Double
    var longitude: Double
    var country: String
    var population: Int
    var is_capital: Bool
    var departureDate: Date?
}



