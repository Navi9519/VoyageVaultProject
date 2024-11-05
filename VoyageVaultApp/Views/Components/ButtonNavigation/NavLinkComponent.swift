//
//  BtnComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-21.
//

import SwiftUI

// <Destination: View>: allows us to specify the desination dynamically. Forces Destination to be a type that conforms to the "View" protocol
struct NavLinkComponent<Destination: View>: View {
    
    
    var text: String
    var width: CGFloat
    var height: CGFloat
    var destination: () -> Destination // By using a closure, the destination view is created only when it’s required
    
    
    var body: some View {
        
        NavigationLink(text, destination: destination)
            .frame(width: width, height: height)
            .foregroundStyle(.white)
            .font(.system(size: 20))
            .bold()
            .background(
            LinearGradient(colors: [
                Color("backgroundOne"),
                Color("backgroundTwo")], startPoint: .leading, endPoint: .trailing)
        ).clipShape(.buttonBorder).shadow(radius: 10)
    }
}

#Preview {
    NavLinkComponent(text: "Login", width: 86, height: 40, destination: {LoginView()})
}
