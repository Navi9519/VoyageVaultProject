//
//  CardComponent.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-22.
//

import SwiftUI

struct HomeCardComponent<Destination: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var title: String
    var description: String
    var image: String
    
    var color1: Color
    var color2: Color
    
    var destination: () -> Destination // By using a closure, the destination view is created only when it’s required
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        
        let textColor = colorScheme == .dark ? Color.white : Color.black
        
        NavigationLink (destination: destination) {
            ZStack {
                
                LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                
                
                HStack (spacing: 10) {
                    Image(image)
                        .resizable()
                        .frame(width: 59, height: 59)
                        .shadow(radius: 5)
                    
                    VStack (spacing: 10) {
                        Text(title)
                            .foregroundStyle(textColor)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text(description)
                            .foregroundStyle(textColor)
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
            .clipShape(.buttonBorder)
        }
    }
    
    
}

#Preview {
    HomeCardComponent(title: "Upcoming trips", description: "Join the Forum to connect with fellow travelers, share tips, and discover new adventures!", image: "imgCalender", color1: Color("beigeColorOne"), color2: Color("backgroundTwo"),destination: {LandingView()})
}
