//
//  RegisterView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct RegisterView: View {
    
    @State var firstName: String = ""
    @State var surName: String = ""
    @State var age: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var nationality: String = ""
    
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
                
                ZStack (alignment: .bottom) {
                    Image("appLogo").resizable().scaledToFit().ignoresSafeArea()
                    
                    Text("Register").padding()
                        .bold()
                        .font(.largeTitle)
                        .padding(.top, 24)
                        
                }
                .frame(height: dynamicScreenHeight / 3)
                
                Spacer()
                
                VStack {
                    HStack (alignment: .bottom) {
                        TxtFieldComponentSmall(title: "First name", txtFieldText: "Enter first name", input: $firstName)
                        
                        
                        TxtFieldComponentSmall(title: "Surname", txtFieldText: "Enter surname", input: $surName)
                            .padding(.top, 20)
                    }
                    
                    HStack(alignment: .bottom) {
                        TxtFieldComponentSmall(title: "Age", txtFieldText: "Enter age", input: $age)
                        
                        
                        TxtFieldComponentSmall(title: "Nationality", txtFieldText: "Enter nationality", input: $nationality)
                            .padding(.top, 20)
                    }
                    
                    TxtFieldComponent(title: "Email", txtFieldText: "Enter email", input: $email).padding(.top, 20)
                    
                    TxtFieldComponent(title: "Password", txtFieldText: "Enter password", input: $password).padding(.top, 20)
                    
                    BtnComponent(text: "Register", width: 86, height: 40)
                        .padding(.top,20)
                    
                }
                .padding(.vertical,20)
                
                Spacer()
               
                NavigationLink(destination: RegisterView(), label: {
                    Text("Already have an account? Login").underline()
                        .foregroundStyle(.white)
                })

                Spacer()
    
                
            }
           
        }
    }
}

#Preview {
    RegisterView()
}
