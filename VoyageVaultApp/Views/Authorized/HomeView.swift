//
//  HomeView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI
import FirebaseStorage

struct HomeView: View {
    
    @EnvironmentObject var firebaseAuth: FirebaseAuth
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let backgroundImage = colorScheme == .dark ? "darkBackgroundPic" : "lightBackgroundPic"
        
        ZStack {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                if let currentUserData = firebaseAuth.currentUserData  {
                    
                    HStack {
                        
                        VStack (alignment: .leading){
                            Text(currentUserData.firstName)
                                .font(.title2)
                            Text(currentUserData.surName)
                                .bold()
                                .font(.title)
                                 .padding(.top,0.5)
                        }
                        
                        Spacer()
                        
                       
                        MenuDropDownView(destinationOne: {ProfileView().environmentObject(Firestorage(firebase: firebaseAuth))}, destinationTwo: {EditProfileView()}, action: {
                            firebaseAuth.signOutUser()
                        })
                        
                        

                    }
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .padding(.top,30)
                    
                    VStack {
                        
                        
                        if let soonestCity = soonestTrip(), let departureDate = soonestCity.departureDate {
                            Text("Time until your next trip: ")
                                .foregroundStyle(.white)
                                .font(.title3)
                            Text("\(calculateDaysUntilTrip(from: departureDate)) days")
                                .foregroundStyle(.white)

                        } else {
                            Text("No upcoming trips right now")
                                .foregroundStyle(.white)
                                .font(.title3)


                        }
                        
                    }
                    .shadow(radius: 10)

                    Spacer()
                    
                    VStack (spacing: 30){
                        HomeCardComponent(
                            title: "Upcoming Trips",
                            description: "Join the Forum to connect with fellow travelers, share tips, and discover new adventures!",
                            image: "imgCalender",
                            color1: Color("beigeColorOne"),
                            color2: Color("beigeColorTwo"),
                            destination: {UpcomingTripsView()})
                        
                        HomeCardComponent(
                            title: "Friend list",
                            description: "Manage your Friend List to stay connected and explore the world together with your travel buddies!",
                            image: "imgFriendList",
                            color1: Color("orangeColorOne"),
                            color2: Color("orangeColorTwo"),
                            destination: {FriendListView()})
                        
                        HomeCardComponent(
                            title: "Explore",
                            description: "Tap Explore to discover exciting destinations, activities, and hidden gems around the world!",
                            image: "imgExplore",
                            color1: Color("blueColorOne"),
                            color2: Color("blueColorTwo"),
                            destination: {ExploreView()})
                    }
                    .shadow(radius: 10)
                
                    Spacer()
                }
            }
        }
    }
    
    private func soonestTrip() -> CityData? {
        return firebaseAuth.currentUserData?.trips
               .sorted { $0.departureDate ?? Date.distantFuture < $1.departureDate ?? Date.distantFuture }
               .first
       }
    
    private func calculateDaysUntilTrip(from departureDate: Date?) -> Int {
            guard let departureDate = departureDate else { return 0 }
        
            let calendar = Calendar.current
            return calendar.dateComponents([.day], from: Date(), to: departureDate).day ?? 0
    }
}

#Preview {
    HomeView().environmentObject(FirebaseAuth()).environmentObject(Firestorage(firebase: FirebaseAuth()))
}
