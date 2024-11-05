    //
    //  FriendProfileView.swift
    //  VoyageVaultApp
    //
    //  Created by Nicholas Nieminen on 2024-11-04.
    //

    import SwiftUI

    struct FriendProfileView: View {
        
        @EnvironmentObject var db: DbConnection
        @EnvironmentObject var storage: Firestorage
        @Environment(\.colorScheme) var colorScheme
    var friendId: String
        
        @State private var currentFriendData: UserData? // @State to hold the retrieved friend data
        
        var body: some View {
            
        let backgroundImage = colorScheme == .dark ? "darkBackgroundPic" : "lightBackgroundPic"
        
        ZStack {
                Image(backgroundImage)
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
                            
                            MenuDropDownView(
                                destinationOne: {ProfileView().environmentObject(Firestorage(firebase: db))}, destinationTwo: {EditProfileView()}, action: {
                                db.signOutUser()
                            }
                            )
                        }
                        .frame(maxWidth: .infinity)
                        .padding(30)
                        .padding(.top,30)
                        
                        VStack (spacing: 30){
                            
                            if !currentFriendData.favoriteDestinations.isEmpty {
                                FavoriteDestinationsCardComponent(
                                    title: "\(currentFriendData.firstName)'s favorite cities:",
                                    cities: currentFriendData.favoriteDestinations,
                                    color1: Color("beigeColorOne"),
                                    color2: Color("backgroundTwo"))
                            } else {
                                Text("No favorite destinations added yet.")
                            }
                            
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
                db.getFriendData(friendId: friendId) { friendData in
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
        FriendProfileView(friendId: "7HEimSn7rJYTNQUA7of5a8Fj21n1").environmentObject(DbConnection()).environmentObject(Firestorage(firebase: DbConnection()))
    }
