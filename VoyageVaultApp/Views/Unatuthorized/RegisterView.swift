//
//  RegisterView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var firebaseAuth: FirebaseAuth
    @Environment(\.dismiss) private var dismiss
    
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
                
                
                VStack {
                    HStack (alignment: .bottom, spacing: 20) {
                        TxtFieldComponentSmall(title: "First name", txtFieldText: "Enter first name", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $firstName)
                        
                        
                        TxtFieldComponentSmall(title: "Surname", txtFieldText: "Enter surname", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $surName)
                            .padding(.top, 20)
                    }
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        TxtFieldComponentSmall(title: "Age", txtFieldText: "Enter age", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $age)
                        
                        
                        TxtFieldComponentSmall(title: "Nationality", txtFieldText: "Enter nationality", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $nationality)
                            .padding(.top, 20)
                    }
                    
                    TxtFieldComponent(title: "Email", txtFieldText: "Enter email", image: "envelope.fill", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $email).padding(.top, 20)
                    
                    SecureTxtFieldComponent(title: "Password", txtFieldText: "Enter password", image: "lock.fill", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $password).padding(.top, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        // TODO: Check this condition later and fix a pop up specifying which input field(s) that are invalid
                        if(firstName.count < 2 || surName.count < 2 || age.isEmpty || nationality.count < 4 || !email.contains("@") || password.count < 6) {
                            
                            print("invalid input, please try again")
                        }  else {
                            
                            firebaseAuth.registerUser(firstName: firstName, surName: surName, age: age, nationality: nationality, email: email, password: password)
                            
                                dismiss()
        
                        
                        }
                          
                        
                        
                        
                    }, label: {
                        Text("Register")
                    }).frame(width: 185, height: 40)
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .bold()
                        .background(
                        LinearGradient(colors: [
                            Color("backgroundOne"),
                            Color("backgroundTwo")            ], startPoint: .leading, endPoint: .trailing)
                    ).clipShape(.buttonBorder).shadow(radius: 10)
                    
                    NavigationLink(destination: LoginView(), label: {
                        Text("Already have an account? Login").underline()
                            .foregroundStyle(.white)
                    })
                    
                }.padding(.top, 0)
                .padding(.vertical, 30)
                
            
                Spacer()
    
                
            }
           
        }
    }
}

#Preview {
    RegisterView().environmentObject(FirebaseAuth())
}
