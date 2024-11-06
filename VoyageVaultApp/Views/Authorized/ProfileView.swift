//
//  ProfileView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-25.
//

import Foundation


import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var storage: Firestorage
    @Environment(\.colorScheme) var colorScheme
    
    @State var isPickerShowing = false
    
    var body: some View {
        
        let backgroundImage = colorScheme == .dark ? "darkBackgroundPic" : "lightBackgroundPic"
        
        ZStack {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                if let currentUserData = db.currentUserData  {
                    
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
                        
                        MenuDropDownView(
                            destinationOne: {ProfileView()},
                            destinationTwo: {EditProfileView()},
                            action: {
                            db.signOutUser()
                        })
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .padding(.top,30)
                    
                    VStack (spacing: 15){
                        
                        if !currentUserData.favoriteDestinations.isEmpty {
                            FavoriteDestinationsCardComponent(
                                title: "\(currentUserData.firstName)'s favorite cities:",
                                cities: currentUserData.favoriteDestinations,
                                color1: Color("beigeColorOne"),
                                color2: Color("backgroundTwo"), showRemoveBtn: true)
                        } else {
                            Text("No favorite destinations added yet.")
                        }
                        
                        if storage.selectedImage != nil {
                            
                            Button(action: {
                                
                                storage.uploadFoto()
                                
                            }, label: {
                                Text("Upload photo")
                            })
                            
                        }
                        
                        ImageVaultCardComponent(
                            title: "\(currentUserData.firstName)'s vault",
                            color1: Color("orangeColorOne"),
                            color2: Color("orangeColorTwo"),
                            addNewPic: {
                                isPickerShowing = true
                            },
                            retrievedImages: $storage.retrievedImages)
                        
                       
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
    ProfileView().environmentObject(DbConnection()).environmentObject(Firestorage(firebase: DbConnection()))
}
