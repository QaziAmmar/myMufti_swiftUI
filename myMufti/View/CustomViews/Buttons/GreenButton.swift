//
//  RedButton.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct GreenBtn: View {
    
    var action: () -> Void
    var title: String
    
    var body: some View {
        Button {
            self.action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 50)
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
                Text(title)
                    .foregroundColor(.white)
                    .font(Font.custom(Popins.bold.rawValue, size: 18))
            }
        }

    }
}

struct GreenBtn_Previews: PreviewProvider {
    static var previews: some View {
        GreenBtn(action: {
            print("ammar is called")
        }, title: "Sign Up")
    }
}
