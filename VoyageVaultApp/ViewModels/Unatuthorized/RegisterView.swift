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
                        VStack (alignment: .leading) {
                            Text("First name").font(.title3).bold()

                            TextField("Enter first name", text: $firstName)
                                .frame(width: 150, height: 40)
                                .background(.yellow)
                                .clipShape(.buttonBorder)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("Surname").font(.title3).bold()
                            
                            SecureField("Enter surname", text: $surName)
                                .frame(width: 150, height: 40)
                                .background(.yellow)
                                .clipShape(.buttonBorder)
                        }.padding(.top, 20)
                    }
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Age").font(.title3).bold()

                            TextField("Enter age", text: $age)
                                .frame(width: 150, height: 40)
                                .background(.yellow)
                                .clipShape(.buttonBorder)
                        }
                        
                        VStack (alignment: .leading) {
                            Text("Nationality").font(.title3).bold()

                            TextField("Enter nationality", text: $nationality)
                                .frame(width: 150, height: 40)
                                .background(.yellow)
                                .clipShape(.buttonBorder)
                        }
                    }
                    
                    VStack (alignment: .leading) {
                        Text("E-mail").font(.title3).bold()

                        TextField("Enter email", text: $email)
                            .frame(width: 300, height: 40)
                            .background(.yellow)
                            .clipShape(.buttonBorder)
                    }
                    VStack (alignment: .leading) {
                        Text("Password").font(.title3).bold()

                        TextField("Enter password", text: $password)
                            .frame(width: 300, height: 40)
                            .background(.yellow)
                            .clipShape(.buttonBorder)
                    }
                    
                    Button("Register", action: {
                        
                    })
                    .frame(width: 70, height: 40)
                    .background(.yellow)
                    .clipShape(.buttonBorder)
                    .padding(.top, 20)
                    .foregroundStyle(.white).bold()
                    
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
