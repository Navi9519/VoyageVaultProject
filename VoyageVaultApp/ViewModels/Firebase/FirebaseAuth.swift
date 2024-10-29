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
    
    
    /////  THE CODE BELOW SHOULD BE MOVED TO A SEPARATE DB FILE /////////////
    
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
    
    
    func addFavoriteDestiantion(city: CityData) {
        
        guard var currentUserData = self.currentUserData else {return}
        guard let currentUser = self.currentUser else {return}
        
        let cityData = [
                "name": city.name,
                "latitude": city.latitude,
                "longitude": city.longitude,
                "country": city.country,
                "population": city.population,
                "is_capital": city.is_capital
            ] as [String : Any]
       
        //updateData() -> Updates only the specified fields without affecting other fields in the document.
        // FieldValue.arrayUnion([cityData]) is a special Firestore function that adds new items to an array field while avoiding duplicates.
        //For individual field updates or incremental additions (like adding a favorite city), updateData with FieldValue.arrayUnion is more efficient and safe.
        
        
        db.collection(COLLECTION_USER_DATA).document(currentUser.uid).updateData([
            "favoriteDestinations": FieldValue.arrayUnion([cityData])
        ]) { error in
            
            if let error = error {
                print("Error updating firestore \(error.localizedDescription)")
            } else {
                
                // Localy appending the new city to the array if firestore update was succesful
                currentUserData.favoriteDestinations.append(city)
                
            }
             
            
        }
        
        
            
    }
    
    func removeFavoriteDestination(city: CityData) {
        guard var currentUserData = self.currentUserData else { return }
        guard let currentUser = self.currentUser else { return }

        let cityData = [
            "name": city.name,
            "latitude": city.latitude,
            "longitude": city.longitude,
            "country": city.country,
            "population": city.population,
            "is_capital": city.is_capital
        ] as [String: Any]
        
        db.collection(COLLECTION_USER_DATA).document(currentUser.uid).updateData([
            "favoriteDestinations": FieldValue.arrayRemove([cityData])
        ]) { error in
            if let error = error {
                print("Error updating Firestore: \(error.localizedDescription)")
            } else {
                // Locally remove the city from the array if Firestore update was successful
                if let index = currentUserData.favoriteDestinations.firstIndex(where: { $0.name == city.name }) {
                    currentUserData.favoriteDestinations.remove(at: index)
                }
            }
        }
    }
    
    
        
    }

