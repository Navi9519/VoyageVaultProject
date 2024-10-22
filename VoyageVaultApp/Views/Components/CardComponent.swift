//
//  CardComponent.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-22.
//

import SwiftUI

struct CardComponent: View {
    
    var title: String
    var description: String
    var image: String
    
    var color1: Color
    var color2: Color
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height

    
    var body: some View {
        
        HStack (spacing: 15) {
            Image(image)
                .resizable()
                .frame(width: 59, height: 59)
                .shadow(radius: 5)
                
            VStack (spacing: 10) {
                Text(title)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,50)

                Text(description)
                    .italic()
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)

            }
        }
        .padding()
        .background(
                    LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                    )
        .clipShape(.buttonBorder)
        .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.30)
        .shadow(radius: 10)
    }
}

#Preview {
    CardComponent(title: "Upcoming trips", description: "Join the Forum to connect with fellow travelers, share tips, and discover new adventures!", image: "imgCalender", color1: Color("beigeColorOne"), color2: Color("backgroundTwo"))
}