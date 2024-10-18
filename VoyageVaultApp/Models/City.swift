//
//  City.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import Foundation


struct City {
    
    var name: String
    var country: String
    var population: Double
    var currency: String
    var position: Position
    
}


struct Position {
    
    var latitude: Double
    var longitude: Double
}
