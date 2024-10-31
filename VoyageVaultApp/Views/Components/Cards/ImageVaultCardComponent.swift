//
//  ImageVaultCardComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-25.
//

import SwiftUI

struct ImageVaultCardComponent: View {
    
    var title: String
    var color1: Color
    var color2: Color
    var addNewPic: () -> Void
    @Binding var retrievedImages: [UIImage]

    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
            
            
            VStack {

                
                ZStack {
                    
                    
                    Text(title)
                        .foregroundStyle(.black)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center).padding(.top, 20)
                    
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action:
                            addNewPic
                        , label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                
                                .padding(.trailing,30)
                                .padding(.top,15)
                                
                        }).foregroundStyle(.black)

                        
                    }
                    .frame(maxWidth: .infinity)
                   
                }
                
               
                Spacer()
                
                VStack {
                    
                    // Loop through the images and display them
                    ForEach(retrievedImages, id: \.self) { image in
                        
                        Image(uiImage: image).resizable().frame(width: 100, height: 100)
                        
                        
                    }
                    
                }
                
                Spacer()
            }
                
                
        }
        .frame(maxWidth: dynamicScreenWidth * 0.90, maxHeight: dynamicScreenHeight * 0.45).cornerRadius(20)
    }
}

#Preview {
    ImageVaultCardComponent(title: "Ivan's vault:", color1: Color("orangeColorOne"), color2: Color("orangeColorTwo"), addNewPic: {
        
    }, retrievedImages: .constant([]))
}
