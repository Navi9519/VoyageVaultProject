//
//  ExploreView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    
    @State var input = ""
    let locationManager = LocationManager()
    
    @State var position = MapCameraPosition
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 54.5260, longitude: 15.2551), span: MKCoordinateSpan(latitudeDelta: 40.0, longitudeDelta: 40.0)))
    
   // Sweden
   // Latitude: 63.1792
   // Longitude: 14.6357
    
    // Finland
    // Latitude: 64.0000
    // Longitude: 26.0000
    
    
    @State var countrysOnMap: [Country] = [Country(name: "Sweden", capital: "Stockholm", cities: [], currency: "Krona", flag: "🇸🇪", location: Location(latitude: 60.4853, longitude: 15.4370)), Country(name: "Finland", capital: "Helsinki", cities: [], currency: "Euro", flag: "🇫🇮", location: Location(latitude: 64.0000, longitude: 26.0000))]
    
    @State var selectedCountry: Country? = nil
    
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
                    
                    SearchFieldComponent(input: $input, txtFieldText: "Search Location", image: "magnifyingglass")
                
                        Map(position: $position) {
                        
                            UserAnnotation()
                            
                            ForEach(countrysOnMap) { country in
                                
                                Annotation("", coordinate: CLLocationCoordinate2D(latitude: country.location.latitude, longitude: country.location.longitude), content: {
                                    
                                    Button(action: {
                                        print("\(country.name) pressed!")
                                        
                                        withAnimation {
                                            if self.selectedCountry?.id == country.id {
                                                self.selectedCountry = nil
                                            } else {
                                                self.selectedCountry = country
                                            }
                                        }
                                        
                                    }, label: {
                                        VStack(spacing: 5) {
                                            Text(country.flag)
                                                .frame(width: 20,height: 20,alignment: .center)
                                            Text(country.name).font(.system(size: 12))
                                                .foregroundStyle(.black)
                                        }
                                    })
                                    
                                })
                                
                            }
                        
                    }
                        .frame(width: 380, height: 400)
                        .cornerRadius(20)
                    
                    VStack {
                        if let selectedCountry = selectedCountry {
                            ExploreCardComponent(country: selectedCountry.name, city: selectedCountry.name, population: 200, currency: selectedCountry.currency, flag: selectedCountry.flag, daysUntilTrip: 24, color1: Color("orangeColorOne"), color2: Color("orangeColorTwo"))
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
