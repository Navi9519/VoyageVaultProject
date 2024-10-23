//
//  ExploreView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct ExploreView: View {
    
    @State var input = ""
    
    
    
    var body: some View {
        
        ZStack {
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                HStack {
                    
                    Text("back")
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill").resizable().scaledToFit().frame(width: 59, height: 59)
                }.frame(width: 300)
                
               
                
                Spacer()
                
                Text("Find your next adventure!").font(.title).bold()
                HStack {
                    
                    TextField("", text: $input, prompt: Text("Search")).frame(width: 300, height: 40)
                        .foregroundStyle(Color.white)
                        .background(.white).cornerRadius(25).textInputAutocapitalization(.never)
                    
                   // Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, -16)
                }
                
                
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.top, 40)
            
         
            
        }
        
        
    }
}

#Preview {
    ExploreView()
}
