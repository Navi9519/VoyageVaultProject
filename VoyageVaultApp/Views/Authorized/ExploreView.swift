    //
    //  ExploreView.swift
    //  VoyageVaultApp
    //
    //  Created by Ivan Dedic on 2024-10-23.
    //

    import SwiftUI
    import MapKit

    struct ExploreView: View {
        
        
        @EnvironmentObject  var db: DbConnection
        @StateObject var countryManager = CountryManager()
        
        let locationManager = LocationManager()
        
        @State var position = MapCameraPosition
            .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                latitude: 54.5260, longitude: 15.2551),
                span: MKCoordinateSpan(latitudeDelta: 40.0, longitudeDelta: 40.0)))
        
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
                    
                        VStack(alignment: .center, spacing: 15) {
                            
                            HStack(alignment: .center) {
                                
                        
                                Spacer()
                                
                                Text("Explore")
                                    .font(.title)
                                    .bold()
                                
                                Spacer()
                                
                                MenuDropDownView(destinationOne: {ProfileView().environmentObject(Firestorage(firebase: db))}, destinationTwo: {EditProfileView()}, action: {
                                    db.signOutUser()
                                })
                                
                                
                                
                                
                                
                            }.frame(width: .infinity, height: 40)
                            
                            
                            Text("Find your next adventure!")
                                .font(.title3)
                            
                        }
                        
                       
                        
                      
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 20) {
                        
                        SearchFieldComponent(
                            input: $input,
                            txtFieldText: "Search Location",
                            image: "magnifyingglass",
                            searchAction: {
                                
                                Task {
                                    do {
                                        try await countryManager.getCityByName(cityName: input)
                                        
                                        if let city = countryManager.city {
                                            position = .region(MKCoordinateRegion(
                                                center: CLLocationCoordinate2D(
                                                latitude: city.latitude, longitude: city.longitude),
                                                span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)))
                                        }
                                    } catch {
                                        print("Error fetching city data: \(error)")
                                    }
                                }
                        })
                        
                        if let city = countryManager.city {
                            
                            Map(position: $position) {
                                
                                UserAnnotation()
                                
                                Annotation("",
                                    coordinate: CLLocationCoordinate2D(
                                    latitude: city.latitude,
                                    longitude: city.longitude),
                                    content: {
                                    
                                        Button(action: {
                                            print("\(city.name) pressed!")
                                            Task {
                                                try await countryManager.getCountryByIso(iso: city.country)
                                            }
                                            
                                            withAnimation {
                                                self.selectedCity = city
                                                self.addToFavorite = db.currentUserData?
                                                    .favoriteDestinations.contains()
                                                    {$0.name == city.name} ?? false
                                            }
                                        }, label: {
                                            ZStack {
                                                Image(systemName: "circle")
                                                    .resizable()
                                                    .frame(width: 80, height: 80)
                                                    .foregroundStyle(.red)
                                                    .background(.gray.opacity(0.5))
                                                    .clipShape(.rect(cornerRadius: 40))
                                                Text(city.name)
                                                    .frame(width: .infinity,height: .infinity,alignment: .center)
                                                    .foregroundStyle(.black)
                                                    .bold()
                                            }
                                            
                                        })
                                    })
                            }
                            .frame(width: 380, height: 400)
                            .cornerRadius(20)
                            
                        } else {
                            Text("Search for a country above")
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
                                    color2: Color("orangeColorTwo"),
                                    addedToFavorite: $addToFavorite,
                                    
                                    addToFavoriteAction: {
                                        
                                        addToFavorite.toggle()
                                        
                                        if addToFavorite == true {
                                            db.addFavoriteDestiantion(city: selectedCity)
                                        } else {
                                            db.removeFavoriteDestination(city: selectedCity)
                                        }
                                        
                                        guard let user = db.currentUserData else {return}
                                        print(user.favoriteDestinations)
                                    })
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity).padding(.top, 40)
            }
        }
    }

    #Preview {
        ExploreView().environmentObject(DbConnection()).environmentObject(Firestorage(firebase: DbConnection()))
    }
