//
//  FriendCardComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct FriendCardComponent<Destination: View>: View {
    
    var firstName: String
    var surName: String
    var country: String
    var deleteFriend: () ->  Void
    var profileImg: String
    
    var color1: Color
    var color2: Color
    
    var destination: () -> Destination // By using a closure, the destination view is created only when it’s required
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        NavigationLink (destination: destination) {
            ZStack {
                
                
                
                LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                
                
                HStack(alignment: .center) {
                    
                   
                    
                    Image(systemName: profileImg)
                        .resizable()
                        .frame(width: 59, height: 59)
                        .shadow(radius: 5).padding(.leading, 30)
                    
                    
                    
                    HStack (spacing: 10) {
                        
                        
                        VStack() {
                            
                            Spacer()
                            
                            HStack () {
                                Text("\(firstName) \(surName)")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                
        
                                Spacer()
                                
                                Image(systemName: "envelope.fill").resizable().scaledToFit().foregroundStyle(.black).frame(width: 30, height: 30).padding(.trailing, 20)
                                
                            }.frame(maxWidth: dynamicScreenWidth * 0.90)
                            
                            Spacer()
                            
                            HStack {
                                
                                Text("Country:")
                                    .foregroundStyle(.black)
                                    .italic()
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .frame(alignment: .center)
                                    .multilineTextAlignment(.center)
                                
                              
                                Text(country).foregroundStyle(.black)
                                    .italic()
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .frame(alignment: .center)
                                    .multilineTextAlignment(.center)
                                
                                Spacer()
                            
                                Button(action: deleteFriend, label: {
                                    Image(systemName: "trash.fill").resizable().scaledToFit().foregroundStyle(.black).frame(width: 30, height: 30).padding(.trailing, 20)
                                })
                                
                            }.frame(maxWidth: dynamicScreenWidth * 0.90)
                            
                            
                            
                            Spacer()
                            
                        }.frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.18)
                        
                        
                       
                        //.padding(.vertical,10) // Optional
                    }
                    .padding().frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.18)
                    
                }
            }
            .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.18) // Frame for the entire card
            .clipShape(.buttonBorder)
        }
    }
    
    
}

#Preview {
    FriendCardComponent(firstName: "David", surName: "Espinoza", country: "Spain", deleteFriend: {}, profileImg: "person.crop.circle.fill", color1: Color("beigeColorOne"), color2: Color("backgroundTwo"), destination: {LandingView()})
}
