//
//  BecomeMuftiSuccessView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import SwiftUI


struct BecomeMuftiSuccessView: View {
    var body: some View {
        loadView()
    }
}



// MARK: - View Extension
extension BecomeMuftiSuccessView {
    
    func loadView() -> some View {
        VStack {
            Spacer()
            
            GifImage("BecomeMuftiDone").offset(y: 100)

            Spacer()
            
            VStack(alignment: .center, spacing: 10) {
                Text("Thanks for your Submission")
                    .font(.custom(Popins.bold.rawValue, size: 30))
                    .multilineTextAlignment(.center)
                
                Text("We’ll notify you once all document varification is done")
                    .font(.custom(Popins.regular.rawValue, size: 12))
            }
            
            GreenBtn(action: {
                UserDefaultManager.muftiSuccess.send(false)
            }, title: "Done")
        }.padding()
    }
    
}


struct BecomeMuftiSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        BecomeMuftiSuccessView()
    }
}
