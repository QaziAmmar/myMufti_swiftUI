//
//  ActionableTextField.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import SwiftUI

struct ActionableTextField: View {
    var placeHolder = String()
    @Binding var text: String
    var action: () -> Void
    
    
    var body: some View {
        normalTF()
    }

    
    func normalTF() -> some View {
        TextField(placeHolder, text: $text)
             .padding(13)
             .foregroundColor(Color.black)
             .background(Color.white)
             .cornerRadius(8)
             .disabled(true)
             .onTapGesture {
                 self.action()
             }

    }
    
}

struct ActionableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ActionableTextField(text: .constant("20-29-2022")) {
            print("action")
        }
    }
}
