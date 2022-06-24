//
//  SearchBar.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 10/03/2022.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding()
                    .frame(width: 24, height: 24)
                
                TextField("Search ...", text: $text)
                    .padding([.trailing,. top, .bottom],7)
                                .font(Font.custom(Popins.medium.rawValue, size: 14))
                                .opacity(isEditing ? 1 : 0.7)
                                .onTapGesture {
                                    self.isEditing = true
                                }
                 
                            if true {
                                Button(action: {
                                    self.isEditing = false
                                    self.text = ""
                 
                                }) {
                                    HStack(spacing: 10) {
                                        Image(ImageName.filter.rawValue)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            
                                        Image(systemName: "multiply")
                                            .foregroundColor(.gray)
                                            .frame(width: 24, height: 24)
                                    }
                                    
                                }
                                .padding(.trailing, 10)
                                .transition(.move(edge: .trailing))
                                
                            }
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
