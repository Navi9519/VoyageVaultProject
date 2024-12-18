    //
    //  AddNewTripView.swift
    //  VoyageVaultApp
    //
    //  Created by Ivan Dedic on 2024-10-23.
    //

    import SwiftUI

    struct AddNewTripView: View {
        
        @StateObject var countryManager = CountryManager ()
        @EnvironmentObject  var db: DbConnection
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.dismiss) var dismiss
    
        @State var selectedCity: CityData? = nil
        @State var selectedDate: Date = Date()
        @State var input = ""
        
        var body: some View {
            
        let backgroundImage = colorScheme == .dark ? "darkBackgroundPic" : "lightBackgroundPic"
        
        let textColor = colorScheme == .dark ? Color.white : Color.black

            ZStack {
                
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 60) {
                    HStack {
                       
                        Spacer()
                        
                        MenuDropDownView(destinationOne: {ProfileView().environmentObject(Firestorage(firebase: db))}, destinationTwo: {EditProfileView()}, action: {
                            db.signOutUser()
                        })
                    }
                    .frame(width: 300)
                   
                    VStack(spacing: 30) {
                        VStack(spacing: 40) {
                            
                            Text("Add a new adventure!")
                                .font(.title)
                                .bold()
                            
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
                            color2: Color("backgroundTwo")
                        )
                        .onChange( of: selectedDate) {
                            selectedCity?.departureDate = selectedDate
                        }
                    
                        BtnComponent(
                            text: "Add",
                            width: 200, height: 80,
                            colorOne: "blueColorOne",
                            colorTwo: "blueColorTwo",
                            txtColor: textColor) {
                                
                                if let city = selectedCity {
                                    print("Adding trip to \(city.name)")
                                    db.addTrip(city: city)
                                    dismiss()
                                }
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 40)
            }
        }
    }

    #Preview {
      AddNewTripView().environmentObject(DbConnection())
    }
