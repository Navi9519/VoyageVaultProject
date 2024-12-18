//
//  FriendCardComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct FriendCardComponent<Destination: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var firstName: String
    var surName: String
    var country: String
    var deleteFriend: () ->  Void
    var profileImg: String
    
    var color1: Color
    var color2: Color
    
    var destination: () -> Destination
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        
        let textColor = colorScheme == .dark ? Color.white : Color.black

            ZStack {
                
                LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                
                
                HStack(alignment: .center) {
                    
                   
                    NavigationLink(destination: destination, label: {
                        Image(systemName: profileImg)
                            .resizable()
                            .frame(width: 59, height: 59)
                            .shadow(radius: 5)
                            .padding(.leading, 30)
                    })
                    
                    HStack (spacing: 10) {
                        
                        VStack() {
                            
                            Spacer()
                            
                            HStack () {
                                Text("\(firstName) \(surName)")
                                    .foregroundStyle(textColor)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
        
                                Spacer()
                                
                                Image(systemName: "envelope.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(textColor)
                                    .frame(width: 30, height: 30)
                                
                            }.frame(maxWidth: dynamicScreenWidth * 0.90)
                            
                            Spacer()
                            
                            HStack {
                                
                                Text("Country:")
                                    .foregroundStyle(textColor)
                                    .italic()
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .frame(alignment: .center)
                                    .multilineTextAlignment(.center)
                                
                              
                                Text(country)
                                    .foregroundStyle(textColor)
                                    .italic()
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .frame(alignment: .center)
                                    .multilineTextAlignment(.center)
                                
                                Spacer()
                            
                                Button(action: deleteFriend, label: {
                                    Image(systemName: "trash.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(textColor)
                                        .frame(width: 30, height: 30)
                                })
                                
                            }.frame(maxWidth: dynamicScreenWidth * 0.90)
                            
                            Spacer()
                            
                        }.frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.18)
                        
                        
                       
                   
                    }
                    .padding().frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.18)
                    
                }
            }
            .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.18)             .clipShape(.buttonBorder)
        
    }
    
    
}

#Preview {
    FriendCardComponent(firstName: "David", surName: "Espinoza", country: "Spain", deleteFriend: {}, profileImg: "person.crop.circle.fill", color1: Color("beigeColorOne"), color2: Color("backgroundTwo"), destination: {FriendProfileView(friendId: "")})
}
