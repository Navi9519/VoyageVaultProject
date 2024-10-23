//
//  FriendListView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct FriendListView: View {
    
    @State var input: String = ""
    
    
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
                    
                    SearchFieldComponent(input: $input, txtFieldText: "Search Friends", image: "magnifyingglass")
                
                    
                    
                    
                }
                
                
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.top, 40)
            
         // TODO: Popup view for selected location, when location is clicked the view with the selected City with corresponding data should appear. Create popup component with data from API
            
        }

    }
}

#Preview {
    FriendListView()
}
