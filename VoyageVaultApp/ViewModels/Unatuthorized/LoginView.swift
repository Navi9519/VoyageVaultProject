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
                
                VStack (alignment: .leading) {
                    Text("E-mail").font(.title3).bold()

                    TextField("Enter email", text: $email)
                        .frame(width: 300, height: 40)
                        .background(.yellow)
                        .clipShape(.buttonBorder)
                }
                
                
                VStack(alignment: .leading) {
                    Text("Password").font(.title3).bold()
                    
                    TextField("Enter password", text: $password)
                        .frame(width: 300, height: 40)
                        .background(.yellow)
                        .clipShape(.buttonBorder)
                }.padding(.top, 20)
                
                Button("Login", action: {
                    
                })
                .frame(width: 70, height: 40)
                .background(.yellow)
                .clipShape(.buttonBorder)
                .padding(.top, 20)
                .foregroundStyle(.white).bold()

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
