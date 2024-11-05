//
//  RegisterView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var firebaseAuth: DbConnection
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var firstName: String = ""
    @State var surName: String = ""
    @State var age: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var nationality: String = ""
    @State var errorMessage: String?
    
    
    
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
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
                    
                    Text("Register").padding()
                        .bold()
                        .font(.largeTitle)
                        .padding(.top, 24)
                    
                }
                .frame(height: dynamicScreenHeight / 3)
                
                
                VStack {
                    HStack (alignment: .bottom, spacing: 20) {
                        TxtFieldComponentSmall(title: "First name", txtFieldText: "Enter first name", txtColor: Color(.white), colorOne: "backgroundOne",  colorTwo: "backgroundTwo", input: $firstName)
                        
                        
                        TxtFieldComponentSmall(title: "Surname", txtFieldText: "Enter surname", txtColor: Color(.white), colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $surName)
                            .padding(.top, 20)
                    }
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        TxtFieldComponentSmall(title: "Age", txtFieldText: "Enter age", txtColor: Color(.white), colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $age)
                        
                        
                        TxtFieldComponentSmall(title: "Nationality", txtFieldText: "Enter nationality", txtColor: Color(.white), colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $nationality)
                            .padding(.top, 20)
                    }
                    
                    TxtFieldComponent(title: "Email", txtFieldText: "Enter email", image: "envelope.fill", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $email).padding(.top, 20)
                    
                    SecureTxtFieldComponent(title: "Password", txtFieldText: "Enter password", image: "lock.fill", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: $password).padding(.top, 20)
                    
                    Spacer()
                    
        
                
                   
                    if let errorMessage = errorMessage ??  firebaseAuth.errorMessage {
                        
                        withAnimation {
                            
                            ErrorMessage(message: errorMessage)
                            
                        }
                        
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        
                        if(validateInputs()) {
                            
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
                                Color("backgroundTwo")], startPoint: .leading, endPoint: .trailing)
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
    
    
    // Method to check for valid inputs, if valid, return true
    private func validateInputs() -> Bool {
            if firstName.count < 2 {
                errorMessage = "First name must be at least 2 characters long."
                return false
            }
            
            if surName.count < 2 {
                errorMessage = "Surname must be at least 2 characters long."
                return false
            }
            
            if age.isEmpty {
                errorMessage = "Please enter your age."
                return false
            }
            
            if nationality.count < 4 {
                errorMessage = "Nationality must be at least 4 characters long."
                return false
            }
            
        
            errorMessage = nil
            return true
        }
    }

#Preview {
    RegisterView().environmentObject(DbConnection())
}
