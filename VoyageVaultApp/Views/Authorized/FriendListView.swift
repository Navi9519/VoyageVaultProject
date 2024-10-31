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
    @StateObject private var userSearchData = UserSearchData(firebaseAuth: FirebaseAuth())
    @EnvironmentObject var firebaseAuth: FirebaseAuth
    
    var body: some View {
        
        ZStack {
            
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 40) {
                
                
                
                HStack {
                    
                    Text("back")
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill").resizable().scaledToFit().frame(width: 59, height: 59)
                }.frame(width: 300)
                
                
               
                VStack(spacing: 30) {
                    
                    VStack(spacing: 20) {
                        
                        Text("Find friends")
                            .font(.title)
                            .bold()
                        
                        SearchFieldComponent(input: $input, txtFieldText: "Search Friends",
                            image: "magnifyingglass",
                            searchAction: {
                            // Search for the user when the button is pressed
                            foundUser = userSearchData.allUsers.first(where: {
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
                                print("Pressed")
                                firebaseAuth.addFriend(user: user)
                            }, label: {
                                Text("Add friend")
                            })
                        }
                        }else if !input.isEmpty {
                            Text("No friend found with that name.")
                            .foregroundColor(.red)
                    }
                    
                    
                    VStack(spacing: 20) {
                        
                        // TODO: Make this a list view of actuall users from DB
                        
                        Text("Your Friends:").font(.title).bold()
                        
                        FriendCardComponent(firstName: "David", surName: "Espinoza", countryImg: "spain", profileImg: "person.crop.circle.fill", color1:  Color("beigeColorOne"), color2: Color("backgroundTwo"), destination: {LandingView()})
                        
                        FriendCardComponent(firstName: "Volodomyr", surName: "Zelensky", countryImg: "ukraine", profileImg: "person.crop.circle.fill", color1:  Color("beigeColorOne"), color2: Color("backgroundTwo"), destination: {LandingView()})
                    }
                    
                }
                
               
                
                
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.top, 40)
            
            
        }

    }
}

#Preview {
    FriendListView()
}
