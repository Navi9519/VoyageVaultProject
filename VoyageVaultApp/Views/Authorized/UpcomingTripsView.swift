//
//  UpcomingTripsView.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-23.
//

import SwiftUI

struct UpcomingTripsView: View {
    var body: some View {
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Image("imgBackHome")
                        .resizable()
                        .frame(width: 75,height: 75)
                    
                    Spacer()
                    
                    Text("Upcoming Trips")
                            .font(.title2)
                    
                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 75,height: 75)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .padding(.top,30)
                .background(.gray)
                
                Spacer()
            }
                
            }
        
    }
}

#Preview {
    UpcomingTripsView()
}
