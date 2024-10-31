//
//  UserSearchData.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-31.
//

import Foundation
import Combine
import FirebaseFirestore

class UserSearchData: ObservableObject {
    
    @Published var allUsers: [UserData] = []
    var db: Firestore

    // Initialize with FirebaseAuth to access its db
    init(firebaseAuth: FirebaseAuth) {
        self.db = firebaseAuth.db
        fetchUsers() // Fetch users when the instance is created
    }

    // Function to fetch users from Firestore
    func fetchUsers() {
        db.collection("user_data").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }

            if let documents = snapshot?.documents {
                // Decode documents to UserData objects
                self.allUsers = documents.compactMap { document in
                    do {
                        let userData = try document.data(as: UserData.self) // Assuming Firestore can decode it directly
                        return userData
                    } catch {
                        print("Error decoding UserData: \(error.localizedDescription)")
                        return nil
                    }
                }
            }
        }
    }
}
