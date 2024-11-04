//
//  ProfileView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-25.
//

import Foundation


import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var firebaseAuth: FirebaseAuth
    @EnvironmentObject var storage: Firestorage
    
    @State var isPickerShowing = false
    
    var body: some View {
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                if let currentUserData = firebaseAuth.currentUserData  {
                    
                    HStack {
                        VStack (alignment: .leading){
                           
                            Text(currentUserData.firstName)
                                .font(.title2)

                            Text(currentUserData.surName)
                                .bold()
                                .font(.title)
                            
                            Text("Age: \(currentUserData.age)")
                                .bold()
                                .font(.title2)
                            
                            Text("Nationality: \(currentUserData.nationality)")
                                .bold()
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        MenuDropDownView(destinationOne: {ProfileView()}, destinationTwo: {EditProfileView()}, action: {
                            firebaseAuth.signOutUser()
                        })
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .padding(.top,30)
                    
                    VStack (spacing: 30){
                        
                        if !currentUserData.favoriteDestinations.isEmpty {
                            FavoriteDestinationsCardComponent(
                                title: "\(currentUserData.firstName)'s favorite cities:",
                                cities: currentUserData.favoriteDestinations,
                                color1: Color("beigeColorOne"),
                                color2: Color("backgroundTwo"))
                        } else {
                            Text("No favorite destinations added yet.")
                        }
                        
                        ImageVaultCardComponent(
                            title: "\(currentUserData.firstName)'s vault",
                            color1: Color("orangeColorOne"),
                            color2: Color("orangeColorTwo"),
                            addNewPic: {
                                isPickerShowing = true
                            },
                            retrievedImages: $storage.retrievedImages)
                        
                        if storage.selectedImage != nil {
                            
                            Button(action: {
                                // Upload the image
                                storage.uploadFoto()
                                
                            }, label: {
                                Text("Upload photo")
                            })
                            
                        }
                        Spacer()
                    }
                    .shadow(radius: 10)
                }
            }
        }.sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                ImagePicker(selectedImage: $storage.selectedImage, isPickerShowing: $isPickerShowing)
        }
        .onAppear {
            storage.retrievePhotos()
        }
    }
}

#Preview {
    ProfileView().environmentObject(FirebaseAuth()).environmentObject(Firestorage(firebase: FirebaseAuth()))
}
