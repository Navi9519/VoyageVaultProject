//
//  ContentView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var firebaseAuth: DbConnection
    
    var body: some View {
        
        if firebaseAuth.currentUser != nil {
            
            NavigationStack {
                
                HomeView()
                
            }
            
        } else {
            
            NavigationStack {
                
                LandingView()
                
            }
        }
        
        
       
        
       
    }
}

#Preview {
    ContentView().environmentObject(DbConnection())
}
