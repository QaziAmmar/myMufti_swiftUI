//
//  MuftiRow.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import SwiftUI

struct MuftiRow: View {
    
    var mufti: Mufti
    var action: (() -> Void)?
    
    var body: some View {
        loadView()
    }
}

extension MuftiRow {
    
    func loadView() -> some View {
        HStack {
            
            mufti.user_img
                .clipShape(Circle())
                .frame(width: 56, height: 56)
                
            
            VStack(alignment: .leading) {
                Text(mufti.name)
                    .font(.custom(Popins.semiBold.rawValue, size: 14))
                    .foregroundColor(Color(ColorName.appBlack.rawValue))
                Text(mufti.experties)
                    .font(.custom(Popins.regular.rawValue, size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button {
                print("Ask Button")
            } label: {
                Text("Ask")
                    .foregroundColor(.black)
                    .font(.custom(Popins.bold.rawValue, size: 16))
            }

        }.padding()
    }
    
    
}

struct MuftiRow_Previews: PreviewProvider {
    static var previews: some View {
        MuftiRow(mufti: Mufti(id: "", name: "", email: "", password: "", phoneNumber: "", image: "", status: "", createdAt: "", modified: "", code: "", fCode: "", gToken: "", fbToken: "", aCode: "", nationality: "", userType: "", degree: "", degreeImage: "", degreeStartDate: "", degreeEndDate: "", instituteName: "", experianceFrom: "", experianceTo: "", totalExperiance: "", shopRegistered: "", emailCode: "", fireBaseID: "", muftiExpertise: []), action: {
            print("hello")
        })
    }
}
