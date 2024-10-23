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
                
                VStack(spacing: 20) {
                    
                    NavLinkComponent(text: "Log in", width: 250, height: 60, destination: { LoginView() } )
                    
                    
                    NavLinkComponent(text: "Create account", width: 250,height: 60, destination: { RegisterView()
                    } )
                    
                }
                Spacer()
                    
                }
                
          
                
            }
            
            
            
        }
        
    }


#Preview {
    LandingView()
}
