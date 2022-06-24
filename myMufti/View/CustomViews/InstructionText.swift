//
//  InstructionText.swift
//  BWR Covid-19 Test
//
//  Created by Ammar on 2/4/22.
//

import SwiftUI

struct InstructionText: View {
    @Binding var count: String
    @Binding var text: String
    
    var body: some View {
        
        HStack(alignment: .top){
            Text("\(count).")
            Text(text)
        }
        .font(.system(size: 15, weight: .medium, design: .default))
        .foregroundColor(Color(ColorName.appGray.rawValue))
        .frame(
             maxWidth: .infinity,
             alignment: .topLeading
           )
        
    }
}

struct InstructionText_Previews: PreviewProvider {
    static var previews: some View {
        InstructionText(count: .constant("1"), text: .constant("hello word"))
    }
}
