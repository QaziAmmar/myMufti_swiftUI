//
//  CustomTextField.swift
//  BWR Covid-19 Test
//
//  Created by Ammar on 2/5/22.
//

import SwiftUI

struct CustomTextField: View {
    
    var placeHolder = String()
    @Binding var text: String
    var isSecure = false
    
    var body: some View {
        Group {
            isSecure ? AnyView(secureTF()) : AnyView( normalTF())
        }
        
    }
    
    func secureTF() -> some View {
        SecureField(placeHolder, text: $text)
        .padding(13)
        .foregroundColor(Color.black)
        .background(Color.white)
        .cornerRadius(8)
//        .placeHolder(Text(placeHolder)
//                        .foregroundColor(.black)
//                        .padding([.leading]), show: text.isEmpty)
    }
    
    func normalTF() -> some View {
        TextField(placeHolder, text: $text)
             .padding(13)
             .foregroundColor(Color.black)
             .background(Color.white)
             .cornerRadius(8)
//             .placeHolder(Text(placeHolder)
//                             .foregroundColor(.black)
//                             .padding([.leading]), show: text.isEmpty)
    }
    
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""))
    }
}
