//
//  RedButton.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct BlackButton: View {
    
    var action: () -> Void
    var title: String
    
    var body: some View {
        Button {
            self.action()
        } label: {
            HStack(spacing: 10) {
                Text(title)
                    .foregroundColor(.black)
                    .font(Font.custom(Popins.bold.rawValue, size: 24))
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.black)
                    
                    Image(ImageName.arrow.rawValue)
                        .resizable()
                        .frame(width: 20, height: 20)
                }

            }
        }

    }
}

struct BlackButton_Previews: PreviewProvider {
    static var previews: some View {
        BlackButton(action: {
            print("ammar is called")
        }, title: "Sign Up")
    }
}
