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
    
    let COLLECTION_FRIEND_DATA = "friend_data"
    let COLLECTION_USER_DATA = "user_data"
    
    @Published var friends: [FriendData] = []
    @Published var trips: [CityData] = [] // Store fetched trips
    
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    @Published var errorMessage: String?
    @Published var fetchedFriendsData: [FriendData] = []
    
    var userDataListener: ListenerRegistration?
    var friendDataListener: ListenerRegistration?
    
    
    init() {
        
      let _ = auth.addStateDidChangeListener {auth, user in
            
          if let user = user {
              
              self.currentUser = user
              self.startUserDataListener()
              self.startFriendDataListener()
              
          } else {
              
              self.currentUser = nil
              self.userDataListener?.remove()
              self.currentUserData = nil
              self.userDataListener = nil
              
              self.friendDataListener?.remove()
              self.friendDataListener = nil
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
                
                do {
                    try self.auth.signOut()
                } catch {
                    
                }
                
                

                
            }
            
            
        }
        
    }
    
    func startFriendDataListener() {

        friendDataListener = db.collection(COLLECTION_FRIEND_DATA).addSnapshotListener{ snapshot, error in
            
            if let error = error {
                print("Error on snapshot \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            self.friends = []
            
            for document in snapshot.documents {
                
                do {
                    let friend = try document.data(as: FriendData.self)
                    
                    self.friends.append(friend)
                } catch let error {
                    print("Omvandlingssfel!: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func addTrip(city: CityData) {
        
        guard var currentUserData = self.currentUserData else {return}
        guard let currentUser = self.currentUser else {return}
        
        let cityData = [
                "name": city.name,
                "latitude": city.latitude,
                "longitude": city.longitude,
                "country": city.country,
                "population": city.population,
                "is_capital": city.is_capital,
                "departureDate": city.departureDate ?? NSNull() // Use NSNull() to omit if no date
            ] as [String : Any]
        
        db.collection(COLLECTION_USER_DATA).document(currentUser.uid).updateData([
            "trips": FieldValue.arrayUnion([cityData])
        ]) { error in
            
            if let error = error {
                print("Error updating firestore \(error.localizedDescription)")
            } else {
                
                // Localy appending the new city to the array if firestore update was succesful
                currentUserData.trips.append(city)
                
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
    
    func addFriend(friendId: String) {
        
        guard let currentUser = currentUser else {
            print("No user is signed in.")
            return
        }
        
        db.collection(COLLECTION_USER_DATA).document(currentUser.uid).updateData(["friends": FieldValue.arrayUnion([friendId])]) { error in
            if let error = error {
                print("Faild to add friend to current users friend list \(error)")
            } else {
                print("Friend added to current users friend list")
            }
        }
    }
    
    func createFriend(friendData: FriendData, friendId: String, completion: @escaping (String?) -> Void) {
        do {
            // Create a document with the specified friendId instead of letting Firestore generate an ID
               let documentRef = db.collection(COLLECTION_FRIEND_DATA).document(friendId)

               // Now, set the data in that document reference and use the documentRef inside the completion block
               try documentRef.setData(from: friendData) { error in
                   if let error = error {
                       print("Failed to add friend data: \(error.localizedDescription)")
                       completion(nil)
                   } else {
                       // Return the document ID of the new friend on success
                       completion(friendId)
                   }
               }
           } catch let error {
               print("Failed to create friend document: \(error.localizedDescription)")
               completion(nil)
           }
    }
    
    
    
    func fetchFriendDataByIds() {
            // Clear existing data
            fetchedFriendsData.removeAll()
            
            guard let friendIds = currentUserData?.friends else { return }

            // Fetch each friend's data based on the IDs
            for friendId in friendIds {
                db.collection(COLLECTION_FRIEND_DATA).document(friendId).getDocument { document, error in
                    if let error = error {
                        print("Error fetching friend data: \(error)")
                    } else if let document = document, document.exists {
                        do {
                            let friendData = try document.data(as: FriendData.self)
                            DispatchQueue.main.async {
                                self.fetchedFriendsData.append(friendData)
                            }
                        } catch {
                            print("Error decoding friend data: \(error)")
                        }
                    }
                }
            }
        }

    
    func deleteFriend(friendId: String) {
        
        let friendToDelete = fetchedFriendsData.first{ $0.id == friendId }
        
        guard let friendToDelete = friendToDelete else {return}
        
        guard let friendId = friendToDelete.id else {return}
        
        db.collection(COLLECTION_FRIEND_DATA).document(friendId).delete()
        
        guard let currentUser = currentUser else {return}
        
        db.collection(COLLECTION_USER_DATA).document(currentUser.uid).updateData([
                       "friends": FieldValue.arrayRemove([friendId])
                ]) { error in
                    if let error = error {
                        print("Failed to remove friend ID from user's friends array: (error)")
                    } else {
                        print("Successfully removed friend ID from user's friends array")
                    }
                }
        
    }
    
    func fetchTrips(for userId: String) {
          db.collection(COLLECTION_USER_DATA).document(userId).getDocument { (document, error) in
              if let document = document, document.exists {
                  if let tripsData = document.data()?["trips"] as? [[String: Any]] {
                      self.trips = tripsData.compactMap { data in
                          // Assuming you can decode the data back into CityData
                          let name = data["name"] as? String ?? ""
                          let latitude = data["latitude"] as? Double ?? 0.0
                          let longitude = data["longitude"] as? Double ?? 0.0
                          let country = data["country"] as? String ?? ""
                          let population = data["population"] as? Int ?? 0
                          let is_capital = data["is_capital"] as? Bool ?? false
                          let departureDate = (data["departureDate"] as? Timestamp)?.dateValue()
                          
                          return CityData(name: name, latitude: latitude, longitude: longitude, country: country, population: population, is_capital: is_capital, departureDate: departureDate)
                      }
                  }
              } else {
                  print("Document does not exist")
              }
          }
      }
    
    
    
        
    }

