//
//  User.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import Foundation
import UIKit
import SwiftUICore
import FirebaseFirestore


struct UserData: Codable {

    @DocumentID var id: String?
    var firstName: String
    var surName: String
    var age: String
    var nationality: String
    var profileImg: String?
    var favoriteDestinations: [CityData] = []
    var trips: [CityData] = []
    var friends: [String] = []
    var messages: [Message] = []
    var images: [String] = []

    
}
