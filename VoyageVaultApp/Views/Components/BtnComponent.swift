//
//  BtnComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-21.
//

import SwiftUI

struct BtnComponent: View {
    
    var text: String
    var width: CGFloat
    var height: CGFloat
    
    
    var body: some View {
        
        NavigationLink(text, destination: LoginView())
            .frame(width: width, height: height)
            .foregroundStyle(.white)
            .font(.system(size: 20))
            .bold()
            .background(
            LinearGradient(colors: [
                Color("backgroundOne"),
                Color("backgroundTwo")            ], startPoint: .leading, endPoint: .trailing)
        ).clipShape(.buttonBorder).shadow(radius: 10)
    }
}

#Preview {
    BtnComponent(text: "Login", width: 86, height: 40)
}
