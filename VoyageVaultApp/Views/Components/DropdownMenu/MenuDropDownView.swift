//
//  MenuDropDownView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-11-04.
//

import SwiftUI

struct MenuDropDownView<Destination: View>: View {
    
    var destination: () -> Destination
    var action: () -> Void
    
    var body: some View {
        
        Menu {
            // First option with its own action
            
            NavigationLink(destination: destination) {
                Label("Edit Profile", systemImage: "person.circle")
            }.foregroundStyle(.black)
            

            // Second option with a different action
            Button(action: action) {
                Label("Log Out", systemImage: "iphone.and.arrow.forward.outward")
            }
            
        } label: {
            
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 70,height: 70).foregroundStyle(.black)
                
        }
    }
}

#Preview {
    MenuDropDownView(destination: {EditProfileView()}, action: {})
}
