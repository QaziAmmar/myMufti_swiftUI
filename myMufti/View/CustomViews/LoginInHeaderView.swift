//
//  LoginInHeaderView.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct LoginInHeaderView: View {
    
    var title = ""
    var subTitle = ""
    var body: some View {
        VStack {
            Image(ImageName.appIcon.rawValue)
                .resizable()
                .frame(width: 70, height: 80, alignment: .center)
            Text(title)
                .font(Font.custom(Popins.semiBold.rawValue, size: 24))
                .foregroundColor(.white)
                
            Text(subTitle)
                .font(Font.custom(Popins.regular.rawValue, size: 14))
                .foregroundColor(.white)
                .opacity(0.65)

        }

    }
}

struct LoginInHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoginInHeaderView()
    }
}
