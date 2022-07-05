//
//  SearchBar.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 10/03/2022.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    var filterAction: (() -> Void)?
    
    var body: some View {
        
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding()
                    .frame(width: 24, height: 24)
                
                TextField("Search ...", text: $text)
                    .padding([.trailing,. top, .bottom],7)
                                .font(Font.custom(Popins.medium.rawValue, size: 14))
                                
                 
                HStack(spacing: 15) {
                    Button {
                        filterAction!()
                    } label: {
                        Image(ImageName.filter.rawValue)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    
                    if !(text.isEmpty) {
                        Button(action: {
//                            self.isEditing = false
                            self.text = ""
         
                        }) {
                                Image(systemName: "multiply")
                                    .foregroundColor(.gray)
                                    .frame(width: 24, height: 24)
                                    .transition(.scale(scale: 0.1, anchor: .center))

                        }
                    }
                    
                }.padding([.trailing, .leading], 10)
                    .transition(.move(edge: .trailing))
                
                
                            
            }
            .padding(5)
            .overlay(
                       RoundedRectangle(cornerRadius: 10)
                           .stroke(Color.gray, lineWidth: 1)
                   )
        
        
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search"))
    }
}
