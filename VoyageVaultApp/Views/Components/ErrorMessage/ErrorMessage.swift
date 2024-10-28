//
//  ErrorMessage.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-28.
//

import SwiftUI

struct ErrorMessage: View {
    
    var message: String
    
    var body: some View {
        
        Text(message).foregroundColor(.red).padding(.vertical).frame(maxWidth: .infinity, maxHeight: 80, alignment: .center).background(.black).bold()
    }
}

#Preview {
    ErrorMessage(message: "Please enter a valid email and password")
}
