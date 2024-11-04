//
//  ApiModel.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-24.
//

import Foundation
import FirebaseFirestore


// This struct represents the nested "data" object in the API response to get flag
struct CountryData: Codable {
    var name: String
    var unicodeFlag: String

}

// This struct represents the entire API response of country API
struct CountryApi: Codable {
    var error: Bool
    var msg: String
    var data: CountryData
}

// The request body struct that will be sent to the API for fetching country ISO
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
    var departureDate: Date?    // Date to departure
}



