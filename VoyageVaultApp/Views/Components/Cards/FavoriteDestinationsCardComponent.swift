//
//  FavoriteDestinationsCardComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-25.
//

import SwiftUI


struct FavoriteDestinationsCardComponent: View {
    
    
    var title: String
    var cities: [CityData]
   
    var color1: Color
    var color2: Color
    var showRemoveBtn: Bool = false
    
    @EnvironmentObject var db: DbConnection
    @StateObject var countryManager = CountryManager()
    @Environment(\.colorScheme) var colorScheme
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    
    
    var body: some View {
        
        let textColor = colorScheme == .dark ? Color.white : Color.black
        
        ZStack {
            
            LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
            
                
                VStack (spacing: 10) {
                    Text(title)
                        .foregroundStyle(textColor)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.vertical,10)
                    
                    ScrollView {
                        ForEach(cities, id: \.name) { city in
                            HStack {
                                Spacer()
                                
                                Text(countryManager.countries[city.country]?.unicodeFlag ?? "🏳️")
                                
                                Text("\(city.name), \(city.country)")
                                
                                Spacer()
                                
                                if showRemoveBtn {
                                    
                                    Button(action: {
                                        
                                        db.removeFavoriteDestination(city: city)
                                        
                                    }, label: {
                                        Image(systemName: "trash")
                                            .resizable().scaledToFit().frame(width: 20, height: 20)
                                            .foregroundStyle(.black)
                                        
                                    })

                                    
                                }
                                
                            }
                            .task {
                                if countryManager.countries[city.country] == nil {
                                    do {
                                        try await countryManager.getCountryByIso(iso: city.country)
                                    } catch {
                                        print("Failed to fetch country flag for \(city.country) : \(error)")
                                    }
                                }
                            }
                        }
                    }

                    
                }
                .padding(.horizontal,20)
                //.padding(.vertical,10) // Optional
        }
        .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.18) // Frame for the entire card
        .clipShape(.buttonBorder)
    }
}

#Preview {
    FavoriteDestinationsCardComponent(title: "Ivans favorite cities:", cities: [
        CityData(name: "Stockholm", latitude: 2323, longitude: 23233, country: "SE", population: 9999999, is_capital: false),
        CityData(name: "Malaga", latitude: 2323, longitude: 23233, country: "ES", population: 9999999, is_capital: false)
        
    ], color1: Color("beigeColorOne"), color2: Color("backgroundTwo")).environmentObject(DbConnection())
}
