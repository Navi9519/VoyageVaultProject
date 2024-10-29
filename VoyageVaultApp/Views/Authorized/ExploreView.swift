//
//  ExploreView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    
    
    @EnvironmentObject  var firebaseAuth: FirebaseAuth
   
    let locationManager = LocationManager()
    
    @StateObject var countryManager = CountryManager()
    
    @State var position = MapCameraPosition
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 54.5260, longitude: 15.2551), span: MKCoordinateSpan(latitudeDelta: 40.0, longitudeDelta: 40.0)))
    
    @State var input = ""
    @State var addToFavorite: Bool = false
    @State var selectedCountry: Country? = nil
    @State var selectedCity: CityData? = nil

    
    var body: some View {
        
        ZStack {
            
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 40) {
                
                ZStack (alignment: .trailing){
                    
                    Spacer()
                        
                    VStack {
                        
                        Text("Explore")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity)
                        
                        Text("Find your next adventure!")
                            .font(.title3)
                    }

                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 59, height: 59)
                        .padding(.trailing,20)
                }
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 20) {
                    
                    SearchFieldComponent(input: $input, txtFieldText: "Search Location", image: "magnifyingglass", searchAction: {
                        
                        Task {
                            do {
                                try await countryManager.getCityByName(cityName: input)
                                
                                if let city = countryManager.city {
                                    position = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude), span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)))
                                }
                                    
                            } catch {
                                print("Error fetching city data: \(error)")
                            }
                        }
                        
                    })
                

                    
                    if let city = countryManager.city {
                    
                        Map(position: $position) {
                        
                            UserAnnotation()
                                
                                Annotation("", coordinate: CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude), content: {
                                        
                                        Button(action: {
                                            print("\(city.name) pressed!")
                                            Task {
                                               try await countryManager.getCountryByIso(iso: city.country)

                                            }
                                            
                                            withAnimation {
                                                self.selectedCity = city
                                                }
                                        }, label: {
                                                Text(city.name)
                                                    .frame(width: 20,height: 20,alignment: .center)
                                                    .background(.red)
                                        })
                                        
                                    })
                            }
                            .frame(width: 380, height: 400)
                            .cornerRadius(20)
                                                        
                    } else {
                        Text("Write something in the search bar")
                    }
                        
                    
                    VStack {
                        if let selectedCity = selectedCity {
                            ExploreCardComponent(
                                country: countryManager.country?.name ?? "",
                                city: selectedCity.name,
                                population: selectedCity.population,
                                isCapital: selectedCity.is_capital,
                                flag: countryManager.country?.unicodeFlag ?? "",
                                daysUntilTrip: 24,
                                color1: Color("orangeColorOne"),
                                color2: Color("orangeColorTwo"), addedToFavorite: $addToFavorite, addToFavoriteAction: {
                                    
                                    addToFavorite.toggle()
                                })
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }

                        
                }
                
                
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.top, 40)
            
         // TODO: Popup view for selected location, when location is clicked the view with the selected City with corresponding data should appear. Create popup component with data from API
            
        }
        
        
    }
}

#Preview {
    ExploreView()
}
