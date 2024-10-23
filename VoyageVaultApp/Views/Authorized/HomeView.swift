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
                .background(.gray)
                .padding(.vertical,30)
                
                Spacer()
                
                CardComponent(title: "Upcoming Trips", description: "Join the Forum to connect with fellow travelers, share tips, and discover new adventures!", image: "imgCalender", color1: Color("beigeColorOne"), color2: Color("beigeColorTwo"))
                
                
            }
                
          
                
            }
        
    }
}

#Preview {
    HomeView()
}
