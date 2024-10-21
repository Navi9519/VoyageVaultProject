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
    @Binding var input: String
    
    var body: some View {
      
        VStack (alignment: .leading) {
            Text(title).font(.title3).bold()

            TextField(txtFieldText, text: $input)
                .frame(width: 300, height: 40)
                .foregroundStyle(Color.white)
                .background(
                    LinearGradient(colors: [
                        Color("backgroundOne"),
                        Color("backgroundTwo")],
                            startPoint: .leading,
                            endPoint: .trailing)
                )
                .clipShape(.buttonBorder)
                .shadow(radius: 10)
        }
       
    }
}

#Preview {
    TxtFieldComponent(title: "Email", txtFieldText: "Enter email", input: .constant("") )
}
