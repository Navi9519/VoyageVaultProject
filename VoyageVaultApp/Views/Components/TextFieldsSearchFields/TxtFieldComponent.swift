//
//  TxtFieldComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-21.
//

import SwiftUI

struct TxtFieldComponent: View {

    var title: String
    var txtFieldText: String
    var image: String
    var colorOne: String
    var colorTwo: String
    @Binding var input: String
    
    
    var body: some View {
      
        VStack (alignment: .leading) {
            Text(title).font(.title3).bold().padding(.leading, 16)
            
    

            HStack {
            
               
                TextField("", text: $input, prompt: Text("Add Email").foregroundStyle(.white))
                    .frame(width: 300, height: 40)
                    .foregroundStyle(Color.white)
                    .background(
                        LinearGradient(colors: [
                            Color(colorOne),
                            Color(colorTwo)],
                                startPoint: .leading,
                                endPoint: .trailing)
                    )
                    .clipShape(.buttonBorder)
                    .shadow(radius: 10).textInputAutocapitalization(.never).overlay(
                        HStack {
                            Image(systemName: image)
                                .foregroundColor(.white)
                                .padding(.leading, 270)
                            Spacer()
                        }
                    )
                    .padding(.horizontal)
            }
           
        }
       
    }
}

#Preview {
    TxtFieldComponent(title: "Email", txtFieldText: "Enter email", image: "envelope", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: .constant("") )
}
