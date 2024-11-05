    //
    //  DatePickerCardComponent.swift
    //  VoyageVaultApp
    //
    //  Created by Ivan Dedic on 2024-10-23.
    //

    import SwiftUI

struct DatePickerCardComponent: View {
        
    var location: String
    @Binding var travelDate: Date
    @Environment(\.colorScheme) var colorScheme
    
    var color1: Color
    var color2: Color
    
    
    var dynamicScreenWidth = UIScreen.main.bounds.width
    var dynamicScreenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        
        let textColor = colorScheme == .dark ? Color.white : Color.black

        ZStack {
            
            LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
            
            VStack() {
                
                Spacer()
                
                Text("Destination: \(location)")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                DatePicker(selection: $travelDate, in: Date.now..., displayedComponents: .date) {
                    
                    Text("Select a date:")
                        .font(.title2)
                        .bold()
                        .lineLimit(1)
                }
                .frame(width: 290)
                .foregroundStyle(textColor)
                
                Spacer()
                
                }.frame(maxWidth: dynamicScreenWidth * 0.9, maxHeight: dynamicScreenHeight * 0.3)
                
            }
            .frame(maxWidth: dynamicScreenWidth * 0.9, maxHeight: dynamicScreenHeight * 0.25) // Frame for the entire card
            .clipShape(.buttonBorder)
        }
        
        
    }
    
        
        #Preview {
            DatePickerCardComponent(location: "Malaga", travelDate: .constant(Date()), color1: Color("beigeColorOne"), color2: Color("backgroundTwo"))
        }
        

