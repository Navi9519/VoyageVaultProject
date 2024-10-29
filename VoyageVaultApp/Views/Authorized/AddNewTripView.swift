//
//  AddNewTripView.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct AddNewTripView: View {
    
    @State var input = ""
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height

    var body: some View {
        
        ZStack {
            
            Image("background_pic")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 60) {
                
                
                
                HStack {
                    
                    Text("back")
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill").resizable().scaledToFit().frame(width: 59, height: 59)
                }.frame(width: 300)
                
                
               
                VStack(spacing: 30) {
                    
                    VStack(spacing: 40) {
                        
                        Text("Add a new adventure!").font(.title).bold()
                        
                        SearchFieldComponent(input: $input, txtFieldText: "Search Location", image: "magnifyingglass", searchAction: {})
                        
                    }
                    
                
                    
                }
                
    
                
                VStack(spacing: 80) {
                    
                    DatePickerCardComponent(location: "Malaga", color1: Color("beigeColorOne"), color2: Color("backgroundTwo"))
                
                    
                    BtnComponent(text: "Add", width: 200, height: 80, colorOne: "blueColorTwo", colorTwo: "blueColorTwo", txtColor: .black) {
                        
                        print("Add new trip")
                    }
                }
                
                
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.top, 40)
            

            
        }
        
        
    }
}


#Preview {
    AddNewTripView()
}
