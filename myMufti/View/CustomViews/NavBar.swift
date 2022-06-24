//
//  NavBar.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct NavBar: View {
    
    var action: () -> Void
    var titile = ""
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    self.action()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 9, height: 14)
                        .foregroundColor(.black)
                }
                .padding([.leading, .trailing, .top])
                Spacer()
                if !titile.isEmpty {
                    Text(titile)
                        .font(.custom(Popins.bold.rawValue, size: 16))
                        .offset(x: -25)
                        .padding([.top])
                }
                
                Spacer()
                    
                    
                
            }.padding([.trailing, .bottom])
            
            if !titile.isEmpty {
                Divider()
                    .frame(height: 0.4)
                    .background(Color.gray.opacity(0.5))
            }
        }
        
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(action: {
            print("back button is pressed")
        })
    }
}
