//
//  SearchField.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct SearchFieldComponent: View {
    
    @Binding var input: String
    var txtFieldText: String
    var image: String
    var searchAction: () -> Void
    
    var body: some View {
        
        TextField(txtFieldText, text: $input).frame(width: 300, height: 40)
            .background(.white).cornerRadius(25).textInputAutocapitalization(.never).overlay(
                
                HStack {
                    
                    Button(action: searchAction, label: {
                        Image(systemName: image)
                            .padding(.leading, 270)
                    }).foregroundStyle(.black)
                    
                   
                    Spacer()
                }
            )
            .padding(.horizontal)
    
        
    
        
    }
}

#Preview {
    SearchFieldComponent(input: .constant(""), txtFieldText: "Search country", image: "magnifyingglass", searchAction: {})
}
