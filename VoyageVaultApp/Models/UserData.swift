//
//  User.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import Foundation
import UIKit
import SwiftUICore


struct UserData: Codable {

    var firstName: String
    var surName: String
    var age: String
    var nationality: String
    var profileImg: String?
    var favoriteDestinations: [Destination] = []
    var trips: [Destination]
    var friends: [UserData] = []
    var messages: [Message] = []
    var images: [String] = []

    
}
