//
//  ContentView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var firebaseAuth: FirebaseAuth
    
    var body: some View {
        
        NavigationStack {
            
            LandingView()
            
        }
        
       
    }
}

#Preview {
    ContentView().environmentObject(FirebaseAuth())
}
