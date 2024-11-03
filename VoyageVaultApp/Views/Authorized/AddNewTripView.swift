//
//  AddNewTripView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct AddNewTripView: View {
    
    @State var input = ""
    
    @StateObject var countryManager = CountryManager ()
    @EnvironmentObject  var firebaseAuth: FirebaseAuth
    
    @State var selectedCity: CityData? = nil
    @State var selectedDate: Date = Date()

    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    // Date formatter to display only the date
       private var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium // Choose a date style like .short, .medium, or .long
           formatter.timeStyle = .none // Hide the time
           return formatter
       }

    var body: some View {
        
        ZStack {
            
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 60) {
                
                
                
                HStack {
                    
                    Text("back")
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill").resizable().scaledToFit().frame(width: 59, height: 59)
                }
                .frame(width: 300)
                
                
               
                VStack(spacing: 30) {
                    
                    VStack(spacing: 40) {
                        
                        Text("Add a new adventure!").font(.title).bold()
                        
                        SearchFieldComponent(
                            input: $input,
                            txtFieldText: "Search Location",
                            image: "magnifyingglass",
                            searchAction: {
                                Task {
                                    do {
                                        try await countryManager.getCityByName(cityName: input)
                                        
                                        if var city = countryManager.city {
                                            city.departureDate = selectedDate
                                            selectedCity = city
                                            print(city)
                                        }
                                        
                                    } catch {
                                        print("Error fetching city data: \(error)")
                                    }
                                }
                        })
                    }
                        
                }
    
                
                VStack(spacing: 80) {
                    
                    DatePickerCardComponent(
                        location: selectedCity?.name ?? "No county selected",
                        travelDate: $selectedDate,
                        color1: Color("beigeColorOne"),
                        color2: Color("backgroundTwo"))
                    .onChange( of: selectedDate) { newDate in
                        selectedCity?.departureDate = newDate
                    }
                
                    
                    BtnComponent(
                        text: "Add",
                        width: 200, height: 80,
                        colorOne: "blueColorTwo",
                        colorTwo: "blueColorTwo",
                        txtColor: .black) {
                        
                            if let city = selectedCity {
                                print("Adding trip to \(city.name) on \(dateFormatter.string(from: city.departureDate ?? Date() ))")
                                
                                firebaseAuth.addTrip(city: city)
                                
                            }
                    }
                }
                
                
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.top, 40)
            

            
        }
        
        
    }
}


#Preview {
    AddNewTripView()
}
