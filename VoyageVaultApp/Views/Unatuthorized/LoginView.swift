//
//  LoginView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme

    
    @EnvironmentObject var firebaseAuth: DbConnection
    
    @State var email = ""
    @State var password = ""
    
    
    var body: some View {
        
        let backgroundImage = colorScheme == .dark ? "darkBackgroundPic" : "lightBackgroundPic"
        
        ZStack {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
                
                ZStack (alignment: .bottom) {
                    Image("appLogo").resizable().scaledToFit().ignoresSafeArea()
                    
                    Text("Login").padding()
                        .bold()
                        .font(.largeTitle)
                        .padding(.top, 24)
                        
                        
                }
                
                Spacer()
                
                TxtFieldComponent(title: "Email", txtFieldText: "Enter email", image: "envelope.fill", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $email)
                
                
                SecureTxtFieldComponent(title: "Password", txtFieldText: "Enter password", image: "lock.fill", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $password)
                
                
                
                BtnComponent(text: "Login", width: 86, height: 40, colorOne: "backgroundOne", colorTwo: "backgroundTwo", txtColor: .white){
                    
                    
                    firebaseAuth.loginUser(email: email, password: password)
                }.padding(.top,10)
                
                Spacer()
                
                if let errorMessage = firebaseAuth.errorMessage {
                    
                    withAnimation {
                        
                        ErrorMessage(message: errorMessage)
                        
                    }
                    
                   
                    
                }

                

                Spacer()
              
                NavigationLink(destination: RegisterView(), label: {
                    Text("Don't have an account? Sign up").underline()
                        .foregroundStyle(.white)
                })
                
            
                Spacer()
            }
            
            
            
        }
    }
}

#Preview {
    LoginView().environmentObject(DbConnection())
}
