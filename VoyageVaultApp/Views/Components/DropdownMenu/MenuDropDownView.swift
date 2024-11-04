//
//  MenuDropDownView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-11-04.
//

import SwiftUI

struct MenuDropDownView<DestinationOne: View, DestinationTwo: View>: View {
    
    var destinationOne: () -> DestinationOne
    var destinationTwo: () -> DestinationTwo
    var action: () -> Void
    
    var body: some View {
        
        Menu {
            // First option with its own action
            
            
            NavigationLink(destination: destinationOne) {
                Label("My Profile", systemImage: "person.circle")
            }.foregroundStyle(.black)
            
            NavigationLink(destination: destinationTwo) {
                Label("Settings", systemImage: "gearshape")
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
    MenuDropDownView(destinationOne: {ProfileView()}, destinationTwo: {EditProfileView()}, action: {})
}
