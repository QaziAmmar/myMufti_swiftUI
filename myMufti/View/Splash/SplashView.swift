//
//  SplashView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import SwiftUI

struct SplashView: View {
    
    @AppStorage(UserDefaultEnum.isSplashOpened.rawValue) var isSplashOpen = false
    
    var body: some View {
        loadView()
            .background(Color.white)
    }
}


// MARK: - View Extension
extension SplashView {
    
    func loadView() -> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Image("splash")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.top, 50)
            
            Text("Trusted and Verified")
                .font(.custom("Medium", size: 28))
                .foregroundColor(Color(hex: "2B532F"))
            
            Text("All Scholar on our platform are verified and background checked. Feel free to ask any type of question.")
                
            
            Rectangle()
                .frame(width: 100, height: 1)
                .foregroundColor(Color(ColorName.appGreen.rawValue))
            
            Text("My Mufti App")
                .foregroundColor(Color(hex: "2B532F"))
                .bold()
                .font(.system(size: 20))
            
            Spacer()
            
            GreenBtn(action: {
                isSplashOpen = true
            }, title: "Enter App")
            
        }.padding()
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
