//
//  LandingView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        let backgroundImage = colorScheme == .dark ? "darkBackgroundPic" : "lightBackgroundPic"

    
        ZStack {
            Image(backgroundImage)
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
    LandingView().environmentObject(DbConnection())
}
