//
//  ExploreCardComponent.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-25.
//

import SwiftUI

struct ExploreCardComponent: View {
            var country: String
            var city: String
            var population: Int
            var currency: String
            var flag: String
            var daysUntilTrip: Int
            
            var color1: Color
            var color2: Color
            
            
            
            var dynamicScreenWidth = UIScreen.main.bounds.width
            var dynamicScreenHeight = UIScreen.main.bounds.height
            
            
            var body: some View {
                ZStack {
                    
                    LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                    
                    VStack (spacing: 10) {
                        
                        
                        HStack {
                            
                            Text(flag)
                                .font(.system(size: 100))
                                .padding(.horizontal,20)
                                .shadow(radius: 5)
                            
                            
                            VStack (spacing: 10) {
                                Text(country)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                
                                Text("in \(daysUntilTrip) days")
                                    .foregroundStyle(.black)
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
                                Text("Currency: \(currency)").font(.title3).bold()
                            }
                            
                            Spacer()
                            
                            HStack (spacing: 15){
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal,30)
                        
                        
                    }
                }
                .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.25) // Frame for the entire card
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                
            }
        
    }


#Preview {
    ExploreCardComponent(country: "Spain", city: "Malaga", population: 571_026, currency: "Euro", flag: "🇪🇸", daysUntilTrip: 24, color1: Color("beigeColorOne"), color2: Color("beigeColorTwo"))
}
