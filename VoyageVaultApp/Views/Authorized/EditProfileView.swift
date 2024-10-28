//
//  EditProfileView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-28.
//

import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject var firebaseAuth: FirebaseAuth
    
    @State var firstName: String = ""
    @State var surName: String = ""
    @State var age: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var nationality: String = ""
    
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack {
                    
                   
                    
                    if let currentUserData = firebaseAuth.currentUserData  {
                        
                        VStack(spacing: 15) {
                            
                            Text("Edit profile").font(.title).bold()
                            
                            
                            HStack (alignment: .bottom, spacing: 20) {
                                TxtFieldComponentSmall(title: "First name", txtFieldText: currentUserData.firstName, txtColor: Color(.black), colorOne: "blueColorOne", colorTwo: "blueColorTwo", input: $firstName)
                                
                                
                                TxtFieldComponentSmall(title: "Surname", txtFieldText: currentUserData.surName, txtColor: Color(.black), colorOne: "blueColorOne", colorTwo: "blueColorTwo", input: $surName)
                                    .padding(.top, 20)
                            }
                            
                            HStack(alignment: .bottom, spacing: 20) {
                                TxtFieldComponentSmall(title: "Age", txtFieldText: currentUserData.age, txtColor: Color(.black), colorOne: "blueColorOne", colorTwo: "blueColorTwo", input: $age)
                                
                                
                                TxtFieldComponentSmall(title: "Nationality", txtFieldText: currentUserData.nationality, txtColor: Color(.black), colorOne: "blueColorOne", colorTwo: "blueColorTwo", input: $nationality)
                                    .padding(.top, 20)
                            }
                            

                            
                            Spacer()
                            
                           

                            
                        }
                        .padding(.vertical, 30)
                        
                        
                        VStack (spacing: 30){
                            
                            
                            VStack {
                               
                                Text("My Cities:").font(.title).bold()
                                
                                FavoriteDestinationsCardComponent(title: "\(currentUserData.firstName)'s favorite cities:", cities: [
                                    CityTest(id: 1, name: "Prague", flag: "🇨🇿"),
                                    CityTest(id: 2, name: "Berlin", flag: "🇩🇪"),
                                    CityTest(id: 3, name: "Tokyo", flag: "🇯🇵")
                                ], color1: Color("blueColorOne"), color2: Color("blueColorTwo"))
                                
                            }
                            
                           
                            
                            
                            VStack {
                                
                                Text("My friends:").font(.title).bold()
                                
                                FriendCardComponent(firstName: "Jari", surName: "Litmanen", countryImg: "ukraine", profileImg: "person.crop.circle.fill", color1: Color("blueColorOne"), color2: Color("blueColorTwo"), destination: {
                                    LandingView()
                                })
                                
                                FriendCardComponent(firstName: "Zlatan", surName: "Ibrahimovic", countryImg: "spain", profileImg: "person.crop.circle.fill", color1: Color("blueColorOne"), color2: Color("blueColorTwo"), destination: {
                                    LandingView()
                                })
                                
                                FriendCardComponent(firstName: "Donald", surName: "Trump", countryImg: "spain", profileImg: "person.crop.circle.fill", color1: Color("blueColorOne"), color2: Color("blueColorTwo"), destination: {
                                    LandingView()
                                })
                                
                                
                            }
                            
                          
                            VStack {
                                
                                Text("My Images:").font(.title).bold()
                                
                                ImageVaultCardComponent(title: "\(currentUserData.firstName)'s vault", color1: Color("blueColorOne"), color2: Color("blueColorTwo"))
                                
                            }
                            
                           
                            
                            Button(action: {
                                
                                // TODO: Edit method to change the data in DB
                        
                                
                            }, label: {
                                Text("Save edit")
                            }).frame(width: 185, height: 40)
                                .foregroundStyle(.black)
                                .font(.system(size: 20))
                                .bold()
                                .background(
                                LinearGradient(colors: [
                                    Color("blueColorOne"),
                                    Color("blueColorTwo")            ], startPoint: .leading, endPoint: .trailing)
                            ).clipShape(.buttonBorder).shadow(radius: 10)
                            
                            
                            
                        }.shadow(radius: 10)
                        

                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
    }
}

#Preview {
    EditProfileView().environmentObject(FirebaseAuth())
}