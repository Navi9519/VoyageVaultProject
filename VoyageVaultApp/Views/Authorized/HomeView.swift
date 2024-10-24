//
//  HomeView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    VStack (alignment: .leading){
                        Text("First name")
                            .font(.title2)
                        Text("Surname")
                            .bold()
                            .font(.title)
                            .padding(.top,0.5)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 75,height: 75)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .padding(.top,30)
                
                VStack {
                    Text("Time until your next trip: ")
                        .foregroundStyle(.white)
                        .font(.title3)
                    Text("24 days, 16 hours and 5 min")
                        .foregroundStyle(.white)
                }
                .shadow(radius: 10)
                
                

                Spacer()
                
                VStack (spacing: 30){
                    HomeCardComponent(title: "Upcoming Trips", description: "Join the Forum to connect with fellow travelers, share tips, and discover new adventures!", image: "imgCalender", color1: Color("beigeColorOne"), color2: Color("beigeColorTwo"),destination: {LandingView()})
                    
                    HomeCardComponent(title: "Friend list", description: "Manage your Friend List to stay connected and explore the world together with your travel buddies!", image: "imgFriendList", color1: Color("orangeColorOne"), color2: Color("orangeColorTwo"),destination: {LandingView()})
                    
                    HomeCardComponent(title: "Explore", description: "Tap Explore to discover exciting destinations, activities, and hidden gems around the world!", image: "imgExplore", color1: Color("blueColorOne"), color2: Color("blueColorTwo"),destination: {LandingView()})
                }.shadow(radius: 10)
                
                
                Spacer()
                
                
            }
                
          
                
            }
        
    }
}

#Preview {
    HomeView()
}
