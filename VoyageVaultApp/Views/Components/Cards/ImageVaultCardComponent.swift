//
//  ImageVaultCardComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-25.
//

import SwiftUI

struct ImageVaultCardComponent: View {
    
    var title: String
    var color1: Color
    var color2: Color
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
            
            
            VStack {
                
                Text(title)
                    .foregroundStyle(.black)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center).padding(.top, 20)
               
                Spacer()
                
                VStack {
                    
                    Text("No images")
                        .foregroundStyle(.black)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                }
                
                Spacer()
            }
                
                
        }
        .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.45).cornerRadius(20)
    }
}

#Preview {
    ImageVaultCardComponent(title: "Ivan's vault:", color1: Color("orangeColorOne"), color2: Color("orangeColorTwo"))
}
