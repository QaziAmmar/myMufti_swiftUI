//
//  DatePickerMLB.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import SwiftUI

struct DatePickerMLB: View {
    
    @State private var date = Date()
    @Binding var showDatePicker: Bool
    var displayedComponents: DatePickerComponents = [.date]
    var action: (Date) -> Void
    
    
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                DatePicker("", selection: $date, displayedComponents: displayedComponents)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .background(
                        Color.white.cornerRadius(10, corners: [.topLeft, .topRight]))
                ZStack(alignment: .topTrailing) {
                    Rectangle()
                        .frame(height: 45)
                        .foregroundColor(.white)
                        .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    
                    HStack {
                        Button {
                            self.action(date)
                        } label: {
                            Text("OK")
                
                        }.background()
                            .padding()
                        Button {
                            showDatePicker = false
                        } label: {
                            Text("Cancel")
                
                        }.background()
                            .padding()
                    }
            
                }
  
            }.padding()

        }
    }
}

struct DatePickerMLB_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerMLB (showDatePicker: .constant(false)) { data  in
            print(data)
        }
    }
}
