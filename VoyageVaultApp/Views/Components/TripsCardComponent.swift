//
//  TripsCardComponent.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-23.
//

import SwiftUI

struct TripsCardComponent: View {
    var title: String
    var description: String
    var image: String
    
    var color1: Color
    var color2: Color
    
    
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
            ZStack {
                
                LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                
                
                HStack (spacing: 10) {
                    Image(image)
                        .resizable()
                        .frame(width: 59, height: 59)
                        .shadow(radius: 5)
                    
                    VStack (spacing: 10) {
                        Text(title)
                            .foregroundStyle(.black)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text(description)
                            .foregroundStyle(.black)
                            .italic()
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(.horizontal,20)
                    //.padding(.vertical,10) // Optional
                }
                .padding()
            }
            .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.18) // Frame for the entire card
            .overlay(
                    RoundedRectangle(cornerRadius: 10)  // Shape of the border
                        .stroke(Color.black, lineWidth: 1)  // Blue border with width 2
                )
        
    }
}

#Preview {
    TripsCardComponent(title: "title", description: "Description", image: "imgBackHome", color1: Color("beigeColorOne"), color2: Color("beigeColorTwo"))
}
