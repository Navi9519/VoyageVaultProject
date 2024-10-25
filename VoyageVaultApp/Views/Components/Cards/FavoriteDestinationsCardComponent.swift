//
//  FavoriteDestinationsCardComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-25.
//

import SwiftUI



struct CityTest: Identifiable {
    
    var id: Int
    var name: String
    var flag: String
    
}


struct FavoriteDestinationsCardComponent: View {
    
    
    var title: String
    var cities: [CityTest]
   
    var color1: Color
    var color2: Color
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
            
                
                VStack (spacing: 10) {
                    Text(title)
                        .foregroundStyle(.black)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                  

                    
                    
                    ForEach(Array(cities.enumerated()), id: \.element.id) { index, city in
                        VStack {
                            
                            Text("\(index + 1). \(city.name) \(city.flag)").bold()
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
        CityTest(id: 1, name: "Prague", flag: "🇨🇿"),
        CityTest(id: 2, name: "Berlin", flag: "🇩🇪"),
        CityTest(id: 3, name: "Tokyo", flag: "🇯🇵")
    ], color1: Color("beigeColorOne"), color2: Color("backgroundTwo"))
}
