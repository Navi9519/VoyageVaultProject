//
//  TxtFieldComponentSmall.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-21.
//

import SwiftUI

struct TxtFieldComponentSmall: View {
    
    var title: String
    var txtFieldText: String
    
    @Binding var input: String
    var body: some View {
        
        VStack (alignment: .leading) {
            Text(title).font(.title3).bold()

            TextField(txtFieldText, text: $input)
                .frame(width: 150, height: 40)
                .foregroundStyle(Color.white)
                .background(
                    LinearGradient(colors: [
                        Color("backgroundOne"),
                        Color("backgroundTwo")],
                            startPoint: .leading,
                            endPoint: .trailing)
                )
                .clipShape(.buttonBorder)
                .shadow(radius: 10).textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    TxtFieldComponentSmall(title: "title", txtFieldText: "enter here", input: .constant(""))
}
