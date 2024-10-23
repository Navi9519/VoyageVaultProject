//
//  FirebaseAuth.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-21.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore


class FirebaseAuth: ObservableObject {
    
    var db = Firestore.firestore()
    let auth = Auth.auth()
    
    
    let COLLECTION_USER_DATA = "user_data"
    @Published var currentUser: User?
    
    
    init() {
        
      let _ = auth.addStateDidChangeListener {auth, user in
            
          if let user = user {
              
              self.currentUser = user
              
          } else {
              
              self.currentUser = nil
          }
            
            
        }
    }
    
    
    func registerUser(firstName: String, surName: String, age: String, nationality: String, email: String, password: String) {
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                
                print(error.localizedDescription)
                
                return
            }
            
            guard let authResult = authResult else {return}
            
            let newUserData = UserData(firstName: firstName, surName: surName, age: age, nationality: nationality, trips: [])
            
            do {
                
                try self.db.collection(self.COLLECTION_USER_DATA).document(authResult.user.uid).setData(from: newUserData)
                   
            } catch let error {
                print("failed to create userData \(error.localizedDescription)")
            }
            
            
        }
           
        
    }
    
    func loginUser(email: String, password: String) {
        
        auth.signIn(withEmail: email, password: password)
        
    }

}
