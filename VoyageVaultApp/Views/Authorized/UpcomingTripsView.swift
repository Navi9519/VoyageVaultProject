//
//  UpcomingTripsView.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-23.
//

import SwiftUI

struct UpcomingTripsView: View {
    
    @StateObject var countryManager = CountryManager()
    
    var body: some View {
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Image(systemName: "arrowshape.backward.circle")
                        .resizable()
                        .frame(width: 70,height: 70)
                        
                    Spacer()
                    
                    Text("Upcoming Trips")
                        .font(.system(size: 30))
                            .bold()
                            .multilineTextAlignment(.center)

                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 70,height: 70)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .padding(.top,30)
                .shadow(radius: 1)
                
                Spacer()
                
                VStack (spacing: 30){
                
                    TripsCardComponent(country: countryManager.country?.name ?? "No Country", city: "Malaga", population: 245_345, currency: "Euro", flag: countryManager.country?.unicodeFlag ?? "", daysUntilTrip: 24, color1: Color("beigeColorOne"), color2: Color("beigeColorTwo"))
                    
                    TripsCardComponent(country: countryManager.country?.name ?? "No Country", city: "Kiev", population: 2_900_000, currency: "ryvnia", flag: countryManager.country?.unicodeFlag ?? "", daysUntilTrip: 142, color1: Color("orangeColorOne"), color2: Color("orangeColorTwo"))
                }
                .shadow(radius: 10)
                
                Spacer()
                
                //Test button
                Button("test", action: {
                    Task {
                        do {
                            
                            try await countryManager.getCountryByName(countryName: "sweden")
                            print("clicked")
                            
                        } catch let error{
                            print(error.localizedDescription)
                        }
                    }
                })
                
                NavLinkComponent(text: "Add new trip", width: 150, height: 50, destination: {AddNewTripView()}).shadow(radius: 10)
                
                Spacer()
            }
        }
    }
}

#Preview {
    UpcomingTripsView()
}
