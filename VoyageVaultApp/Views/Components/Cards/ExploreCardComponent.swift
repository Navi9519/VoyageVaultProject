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
            
     @State var addedToFavorite = false
            
            var dynamicScreenWidth = UIScreen.main.bounds.width
            var dynamicScreenHeight = UIScreen.main.bounds.height
            
            
            var body: some View {
                ZStack {
                    
                    LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                    
                    VStack (spacing: 0) {
                        
                        
                        HStack {
                            
                            Text(flag)
                                .font(.system(size: 80))
                                .padding(.horizontal,25)
                                .shadow(radius: 5)
                            
                            Spacer()
                            
                                Text(country)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal,20)
                        }
                        
                        HStack(alignment: .bottom){
                            VStack (alignment: .leading){
                                Text("Country: \(country)").font(.title3).bold()
                                Text("Population: \(population)").font(.title3).bold()
                                Text("Currency: \(currency)").font(.title3).bold()
                            }
                            .padding(.bottom,20)
                            
                            Spacer()
                            
                            HStack (spacing: 15){
                                
                                Button(action: {
                                    addedToFavorite.toggle()
                                }, label:{
                                    if (addedToFavorite == false) {
                                    Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.black)
                                    .padding(.bottom,30)
                                    } else {
                                        Image(systemName: "heart.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.red)
                                        .padding(.bottom,30)
                                    }
                                })
                                
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal,30)
                        
                        
                    }
                }
                .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.20) // Frame for the entire card
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
