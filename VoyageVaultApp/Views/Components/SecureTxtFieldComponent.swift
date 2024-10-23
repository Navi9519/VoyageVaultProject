//
//  secureTxtFieldComponent.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-21.
//

import SwiftUI

struct SecureTxtFieldComponent: View {
    var title: String
    var txtFieldText: String
    var image: String
    @Binding var input: String
    
    var body: some View {
      
        VStack (alignment: .leading) {
            Text(title).font(.title3).bold().padding(.leading, 35)
            
            HStack {
                
                Image(systemName: image).foregroundStyle(Color("backgroundOne")).bold()
                
                SecureField(txtFieldText, text: $input)
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
                    .shadow(radius: 10).textInputAutocapitalization(.never)
            }

            
        }
       
    }
}


#Preview {
    SecureTxtFieldComponent(title: "Password", txtFieldText: "Enter password", image: "lock.fill", input: .constant(""))
}
