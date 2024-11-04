//
//  FriendProfileView.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-11-04.
//

import SwiftUI

struct FriendProfileView: View {
    
    @EnvironmentObject var firebaseAuth: FirebaseAuth
    @ObservedObject var storage: Firestorage
    var friendId: String
    
    @State private var currentFriendData: UserData? // @State to hold the retrieved friend data
    
    var body: some View {
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                if let currentFriendData = currentFriendData  {
                    
                    HStack {
                        VStack (alignment: .leading){
                            
                            Text(currentFriendData.firstName)
                                .font(.title2)
                            
                            Text(currentFriendData.surName)
                                .bold()
                                .font(.title)
                            
                            Text("Age: \(currentFriendData.age)")
                                .bold()
                                .font(.title2)
                            
                            Text("Nationality: \(currentFriendData.nationality)")
                                .bold()
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            firebaseAuth.signOutUser()
                        }, label: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 70,height: 70)
                        })
                        .foregroundStyle(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .padding(.top,30)
                    
                    VStack (spacing: 30){
                        
                        FavoriteDestinationsCardComponent(
                            title: "\(currentFriendData.firstName)'s favorite cities:",
                            cities: [
                                CityTest(id: 1, name: "Prague", flag: "🇨🇿"),
                                CityTest(id: 2, name: "Berlin", flag: "🇩🇪"),
                                CityTest(id: 3, name: "Tokyo", flag: "🇯🇵")
                            ],
                            color1: Color("beigeColorOne"),
                            color2: Color("backgroundTwo"))
                        
                        ImageVaultCardComponent(
                            title: "\(currentFriendData.firstName)'s vault",
                            color1: Color("orangeColorOne"),
                            color2: Color("orangeColorTwo"),
                            addNewPic: {
                                print(friendId)
                            },
                            retrievedImages: $storage.retrievedImages)
                        
                        Spacer()
                    }
                    .shadow(radius: 10)
                } else {
                    Text("Loading friend data...")
                        .font(.title)
                        .foregroundStyle(.gray)
                }
            }
        }
        .onAppear {
            // Trigger data fetching when the view appears
            firebaseAuth.getFriendData(friendId: friendId) { friendData in
                if let friendData = friendData {
                    DispatchQueue.main.async {
                        self.currentFriendData = friendData
                    }
                } else {
                    print("Failed to load friend data.")
                }
            }
            storage.retriveFriendPhotos(userId: friendId)  // Retrieve friend's images
        }
    }
}


#Preview {
    FriendProfileView(storage: Firestorage(firebase: FirebaseAuth()), friendId: "").environmentObject(FirebaseAuth())
}
