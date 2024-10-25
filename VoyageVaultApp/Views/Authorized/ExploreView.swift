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
                
                VStack(spacing: 30) {
                    
                    
                    
                    SearchFieldComponent(input: $input, txtFieldText: "Search Location", image: "magnifyingglass")
                
                    
                        Map(position: $position) {
                        
                        
                    }
                        .frame(width: 380, height: 400)
                        .cornerRadius(20)
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
