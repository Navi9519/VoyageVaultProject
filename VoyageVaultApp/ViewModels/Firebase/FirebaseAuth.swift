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
    @Published var currentUserData: UserData?
    @Published var errorMessage: String?
    
    var userDataListener: ListenerRegistration?
    
    
    init() {
        
      let _ = auth.addStateDidChangeListener {auth, user in
            
          if let user = user {
              
              self.currentUser = user
              self.startUserDataListener()
              
          } else {
              
              self.currentUser = nil
              self.currentUserData = nil
              self.userDataListener?.remove()
              self.userDataListener = nil
          }
            
            
        }
    }
    
    
    func registerUser(firstName: String, surName: String, age: String, nationality: String, email: String, password: String) {
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                
                print(error.localizedDescription)
                
                self.errorMessage = error.localizedDescription
                
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
        
      
        
        auth.signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                
                print(error.localizedDescription)
                
                self.errorMessage = error.localizedDescription
                
                return
            }
            
            
        }
        
    }
    
    func signOutUser() {
        do {
            try auth.signOut()
            currentUser = nil
        } catch _ {
            
        }
    }
    
    
    func startUserDataListener() {
        
        guard let currentUser = currentUser else {return}
        
        userDataListener = db.collection(COLLECTION_USER_DATA).document(currentUser.uid).addSnapshotListener { snapshot, error in
            
            if let error = error {
                
                print("Error listening to user data \(error.localizedDescription)")
                
                return
            }
            
            guard let snapshot = snapshot else {return}
            
            do {
                
                self.currentUserData = try snapshot.data(as: UserData.self)
                
            } catch _ {
                
                print("Omvanlingsfel! Kunde inte omvandla användarens data")
                
            }
            
            
        }
        
    }

}
