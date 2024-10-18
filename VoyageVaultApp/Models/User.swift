//
//  User.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import Foundation
import UIKit
import SwiftUICore


struct UserData {
    
    var id: String
    var firstName: String
    var surName: String
    var age: Int
    var email: String
    var password: String
    var nationality: String
    var profileImg: String
    var favoriteDestinations: [Destination] = []
    var trips: [Destination]
    var friends: [UserData] = []
    var messages: [Message] = []
    var images: [Image] = []

    
}
