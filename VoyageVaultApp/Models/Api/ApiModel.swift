//
//  ApiModel.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-24.
//

import Foundation

import Foundation

// This struct represents the nested "data" object in the API response
struct CountryData: Codable {
    var name: String
    var unicodeFlag: String
}

// This struct represents the entire API response
struct CountryApi: Codable {
    var error: Bool
    var msg: String
    var data: CountryData
}

// The request body struct that will be sent to the API
struct CountryRequest: Encodable {
    let country: String
}

