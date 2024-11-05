//
//  SearchField.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-23.
//

import SwiftUI

struct SearchFieldComponent: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var input: String
    var txtFieldText: String
    var image: String
    var searchAction: () -> Void
    
    var body: some View {
        
        let textColor = colorScheme == .dark ? Color.white : Color.black
        
        TextField(txtFieldText, text: $input)
            .frame(width: 300, height: 40)
            .background(.white)
            .cornerRadius(25)
            .textInputAutocapitalization(.never)
            .overlay(
                
                HStack {
                    
                    Spacer()
                    
                    Button(
                        action: searchAction,
                        label: {
                            Image(systemName: image)
                        
                            
                    })
                    .frame(width: 20)
                    .foregroundStyle(.black)
                }
            )
    }
}

#Preview {
    SearchFieldComponent(input: .constant(""), txtFieldText: "Search country", image: "magnifyingglass", searchAction: {})
}
