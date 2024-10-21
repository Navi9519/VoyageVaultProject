//
//  Message.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import Foundation


struct Message: Codable {
    
    var subject: String
    var content: String
    var reciever: UserData
}
