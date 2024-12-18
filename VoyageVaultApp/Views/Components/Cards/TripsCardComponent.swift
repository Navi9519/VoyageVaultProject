//
//  TripsCardComponent.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-23.
//

import SwiftUI

struct TripsCardComponent: View {
    
    @Environment(\.colorScheme) var colorScheme

    var country: String
    var city: String
    var population: Int
    var isCapital: Bool
    var flag: String
    var daysUntilTrip: Int
    var deleteTrip: () ->  Void
    
    var color1: Color
    var color2: Color
    
    
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        
        let textColor = colorScheme == .dark ? Color.white : Color.black

        ZStack {
            
            LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
            
            VStack (spacing: 30) {
                
                Spacer()
                
                HStack {
                    
                    Text(flag)
                        .font(.system(size: 100))
                        .padding(.horizontal,20)
                        .shadow(radius: 5)
                    
                    
                    VStack (spacing: 10) {
                        Text(city)
                            .foregroundStyle(textColor)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("in \(daysUntilTrip) days")
                            .foregroundStyle(textColor)
                            .italic()
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal,20)
                    
                    Spacer()
                }
                
                HStack(alignment: .bottom){
                    VStack (alignment: .leading){
                        Text("Country: \(country)").font(.title3).bold()
                        Text("Population: \(population)").font(.title3).bold()
                        Text("Is Capital?: \(isCapital)").font(.title3).bold()
                    }
                    
                    Spacer()
                    
                    HStack (spacing: 15){
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Button(action: deleteTrip, label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 30, height: 30).foregroundStyle(.black)
                            
                        })
                       
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,30)
                
                Spacer()
                
            }
        }
        .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.30) 
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        
    }
}

#Preview {
    TripsCardComponent(country: "Spain", city: "Malaga", population: 571_026, isCapital: false, flag: "🇪🇸", daysUntilTrip: 24, deleteTrip: {}, color1: Color("beigeColorOne"), color2: Color("beigeColorTwo"))
}
