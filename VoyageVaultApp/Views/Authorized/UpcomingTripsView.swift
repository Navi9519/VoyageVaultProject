//
//  UpcomingTripsView.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-23.
//

import SwiftUI

struct UpcomingTripsView: View {
    
    @StateObject var countryManager = CountryManager()
    @EnvironmentObject var db: DbConnection
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let backgroundImage = colorScheme == .dark ? "darkBackgroundPic" : "lightBackgroundPic"
        
        ZStack {
            Image(backgroundImage)
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
                    
                    MenuDropDownView(destinationOne: {ProfileView().environmentObject(Firestorage(firebase: db))}, destinationTwo: {EditProfileView()}, action: {
                        db.signOutUser()
                    })
                    
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .padding(.top,30)
                .shadow(radius: 1)
                
                Spacer()
                
                VStack (spacing: 30){
                    
                    NavLinkComponent(
                        text: "Add new trip",
                        width: 150,
                        height: 50,
                        destination: {
                            AddNewTripView()
                        })
                    
                    
                    
                    ScrollView {
                        
                        
                      
                        ForEach(db.trips, id: \.name) { trip in
                          
                            
                            let countryData = countryManager.countries[trip.country]
                            

                            TripsCardComponent(
                                country: countryData?.name ?? "Unknown Country",
                                city: trip.name,
                                population: trip.population,
                                isCapital: trip.is_capital,
                                flag: countryData?.unicodeFlag ?? "No flag avalible",
                                daysUntilTrip: calculateDaysUntilTrip(from: trip.departureDate),
                                deleteTrip: {
                                    
                                    db.removeTrip(city: trip)
                                    
                                },
                                color1: Color("orangeColorOne"),
                                color2: Color("orangeColorTwo")
                            )
                            .task {
                                // Only fetch if the country data isn't already cached
                                if countryData == nil {
                                    do {
                                        try await countryManager.getCountryByIso(iso: trip.country)
                                    } catch {
                                        print("Failed to fetch country data: \(error)")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .shadow(radius: 10)
                
            Spacer()
            
        }
        .onAppear {
            if let userId = db.currentUser?.uid {
                db.fetchTrips(for: userId) // Fetch trips when view appears
            }
        }
    }
}
    
private func calculateDaysUntilTrip(from departureDate: Date?) -> Int {
        guard let departureDate = departureDate else { return 0 }
    
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: Date(), to: departureDate).day ?? 0
}

#Preview {
    UpcomingTripsView().environmentObject(DbConnection()).environmentObject(Firestorage(firebase: DbConnection()))
}
