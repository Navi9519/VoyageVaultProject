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
    var colorOne: String
    var colorTwo: String
    
    @Binding var input: String
    var body: some View {
        
        VStack (alignment: .leading) {
            Text(title).font(.title3).bold()

            TextField("", text: $input, prompt: Text(txtFieldText).foregroundStyle(.white))
                .frame(width: 150, height: 40)
                .foregroundStyle(Color.white)
                .background(
                    LinearGradient(colors: [
                        Color(colorOne),
                        Color(colorTwo)],
                            startPoint: .leading,
                            endPoint: .trailing)
                )
                .clipShape(.buttonBorder)
                .shadow(radius: 10).textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    TxtFieldComponentSmall(title: "title", txtFieldText: "enter here", colorOne: "backgroundOne", colorTwo: "backgroundTwo", input: .constant(""))
}
