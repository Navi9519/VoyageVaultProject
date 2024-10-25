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
                        
                        Button(action: {
                            firebaseAuth.signOutUser()
                        }, label: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 70,height: 70)
                        }).foregroundStyle(.black)

                        
                       
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .padding(.top,30)
                    
                    
                    VStack (spacing: 30){
                        
                        FavoriteDestinationsCardComponent(title: "\(currentUserData.firstName)'s favorite cities:", cities: [
                            CityTest(id: 1, name: "Prague", flag: "🇨🇿"),
                            CityTest(id: 2, name: "Berlin", flag: "🇩🇪"),
                            CityTest(id: 3, name: "Tokyo", flag: "🇯🇵")
                        ], color1: Color("beigeColorOne"), color2: Color("backgroundTwo"))
                        
                        
                        ImageVaultCardComponent(title: "\(currentUserData.firstName)'s vault", color1: Color("orangeColorOne"), color2: Color("orangeColorTwo"))
                        
                       
                    }.shadow(radius: 10)
                    
                    
                    
                    
                   
                    
                    
                }
                    
                }
                
               
                
          
                
            }
        
    }
}

#Preview {
    ProfileView().environmentObject(FirebaseAuth())
}
