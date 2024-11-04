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
                            
                            Text("Edit profile")
                                .font(.title)
                                .bold()
                            
                            HStack (alignment: .bottom, spacing: 20) {
                                TxtFieldComponentSmall(
                                    title: "First name",
                                    txtFieldText: currentUserData.firstName,
                                    txtColor: Color(.black),
                                    colorOne: "blueColorOne",
                                    colorTwo: "blueColorTwo",
                                    input: $firstName)
                                
                                TxtFieldComponentSmall(
                                    title: "Surname",
                                    txtFieldText: currentUserData.surName,
                                    txtColor: Color(.black),
                                    colorOne: "blueColorOne",
                                    colorTwo: "blueColorTwo",
                                    input: $surName)
                                    .padding(.top, 20)
                            }
                            
                            HStack(alignment: .bottom, spacing: 20) {
                                TxtFieldComponentSmall(
                                    title: "Age",
                                    txtFieldText: currentUserData.age,
                                    txtColor: Color(.black),
                                    colorOne: "blueColorOne",
                                    colorTwo: "blueColorTwo",
                                    input: $age)
                                
                                TxtFieldComponentSmall(
                                    title: "Nationality",
                                    txtFieldText: currentUserData.nationality,
                                    txtColor: Color(.black),
                                    colorOne: "blueColorOne",
                                    colorTwo: "blueColorTwo",
                                    input: $nationality)
                                    .padding(.top, 20)
                            }
                        
                            Spacer()
                            
                        }
                        .padding(.vertical, 30)
                        
                            
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
                                    Color("blueColorTwo")
                                ],
                                startPoint: .leading,
                                endPoint: .trailing)
                            )
                                .clipShape(.buttonBorder)
                                .shadow(radius: 10)
                        }
                        
                    }
                }
            }
        }
    }

#Preview {
    EditProfileView().environmentObject(FirebaseAuth()).environmentObject(Firestorage(firebase: FirebaseAuth()))
}
