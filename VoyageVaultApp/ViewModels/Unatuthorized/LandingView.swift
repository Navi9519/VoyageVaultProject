//
//  LandingView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
    
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
                
                Image("appLogo").resizable().scaledToFit().ignoresSafeArea()
                
                Spacer()
                
                ZStack {
                    Image("input&btn")
                    
                    NavigationLink("Sign in", destination: LoginView()).foregroundStyle(.white).font(.title2).bold()
                    
                }
                
                
                ZStack {
                    Image("input&btn")
                    
                    NavigationLink("Create Account", destination: RegisterView()).foregroundStyle(.white).font(.title2).bold()
                    
                }.padding(.top, 20)
                
                
                Spacer()
            }
            
            
            
        }
        
    }
}

#Preview {
    LandingView()
}
