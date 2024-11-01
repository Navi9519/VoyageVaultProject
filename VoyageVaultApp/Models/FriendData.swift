//
//  FriendData.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-31.
//

import Foundation
import FirebaseFirestore

struct FriendData: Codable, Identifiable {
    
    @DocumentID var id: String?
    var firstName: String
    var surName: String
    var age: String
    var nationality: String
    var profileImg: String?
    var favoriteDestinations: [CityData] = []
    var images: [String] = []
}


