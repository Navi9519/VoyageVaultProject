//
//  FriendListView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct FriendListView: View {
    
    @State var input: String = ""
    @State private var foundUser: UserData? // Variable to hold the found user
   
    @EnvironmentObject var db: DbConnection
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let backgroundImage = colorScheme == .dark ? "darkBackgroundPic" : "lightBackgroundPic"
        
        ZStack {
            
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 40) {
                HStack {
                    
                    Spacer()
                   
                
                    MenuDropDownView(
                        destinationOne:{ProfileView().environmentObject(Firestorage(firebase: db))},
                        destinationTwo: {EditProfileView()},
                        action: {
                        db.signOutUser()
                    })
                    
                }
                .frame(width: 300)
                
                VStack(spacing: 30) {
                    VStack(spacing: 20) {
                        
                        Text("Find friends")
                            .font(.title)
                            .bold()
                        
                        SearchFieldComponent(
                            input: $input,
                            txtFieldText: "Search Friends",
                            image: "magnifyingglass",
                            searchAction: {
                            
                                foundUser = db.allUsers.first(where: {
                                    $0.firstName.lowercased() == input.lowercased() ||
                                    $0.surName.lowercased() == input.lowercased()
                                })
                            })
                    }
                    
                    if let user = foundUser {
                        
                        
                        HStack {
                            Text("\(user.firstName) \(user.surName)")
                                .font(.title2)
                                .foregroundStyle(.black)
                            
                            Button(action: {
                                
                                guard let friendId = user.id else {return}

                                
                                let newFriend = FriendData(
                                    id: friendId,
                                    firstName: user.firstName,
                                    surName: user.surName,
                                    age: user.age,
                                    nationality: user.nationality
                                )
                                
                                db.createFriend(friendData: newFriend, friendId: friendId) { friendId in
                                    
                                    guard let friendId = friendId else {return}
                                    
                                    db.addFriend(friendId: friendId)
                                }
                             
                                
                            }, label: {
                                Text("Add friend")
                            })
                        }
                    }else if !input.isEmpty {
                        Text("No friend found with that name.")
                        .foregroundColor(.red)
                    }
                    
                    VStack(spacing: 20) {
                        
                        Text("Your Friends:")
                            .font(.title)
                            .bold()
                        
                        ScrollView {
                            if db.currentUserFriendsData.isEmpty {
                            
                                Spacer()
                                
                                Text("No friends added")
                                        .font(.title)
                                        .bold()
                                        .foregroundStyle(.red)
                                
                                Spacer()
                            } else {
                            
                                ForEach(db.currentUserFriendsData) { friend in
                                        
                                        FriendCardComponent(
                                        firstName: friend.firstName,
                                        surName: friend.surName,
                                        country: friend.nationality,
                                        deleteFriend: {
                                            
                                            guard let friendId = friend.id else {return}
                                            
                                            db.deleteFriend(friendId: friendId)
                                        },
                                        profileImg: "person.crop.circle.fill",
                                        color1: Color("beigeColorOne"),
                                        color2: Color("beigeColorTwo"),
                                        destination: {FriendProfileView( friendId: friend.id ?? "").environmentObject(Firestorage(firebase: db))})
                                        
                                    }
                            }
                        }
                    }
                }.onAppear {
                    
                    db.fetchUsers()
                }
            
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 40)
            .onAppear {
                db.fetchFriendDataByIds()
            }
        }
    }
}

#Preview {
    FriendListView().environmentObject(DbConnection()).environmentObject(Firestorage(firebase: DbConnection()))
}
