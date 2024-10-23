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
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.309857850079666, longitude: 18.022240207022453), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    
    
    var body: some View {
        
        ZStack {
            
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 40) {
                
                
                
                HStack {
                    
                    Text("back")
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill").resizable().scaledToFit().frame(width: 59, height: 59)
                }.frame(width: 300)
                
                
               
                VStack(spacing: 30) {
                    
                    VStack(spacing: 5) {
                        
                        Text("Explore").font(.title).bold()
                        
                        Text("Find your next adventure!").font(.title).bold()
                        
                    }
                    
                    
                    
                    
                    TextField("", text: $input).frame(width: 300, height: 40)
                        .foregroundStyle(Color.white)
                        .background(.white).cornerRadius(25).textInputAutocapitalization(.never).overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 12)
                                Spacer()
                            }
                        )
                        .padding(.horizontal)
                
                    
                        Map(position: $position) {
                        
                        
                    }.frame(width: 380, height: 400).cornerRadius(20)
                    
                }
                
                
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.top, 40)
            
         
            
        }
        
        
    }
}

#Preview {
    ExploreView()
}
