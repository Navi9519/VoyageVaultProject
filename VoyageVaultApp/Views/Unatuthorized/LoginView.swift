//
//  LoginView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Image("background_pic")
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
                
                TxtFieldComponent(title: "Email", txtFieldText: "Enter email", input: $email)
                
                
                secureTxtFieldComponent(title: "Password", txtFieldText: "Enter password", input: $password)
                
                // TODO: Change this navigation to HomeView() when HomeView is created
                BtnComponent(text: "Login", width: 86, height: 40, destination: {
                    LandingView()
                }).padding(.vertical,20)

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
    LoginView()
}
