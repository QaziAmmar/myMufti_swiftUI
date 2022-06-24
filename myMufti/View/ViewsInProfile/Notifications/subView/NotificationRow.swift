//
//  NotificationRow.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 21/06/2022.
//

import SwiftUI

struct NotificationRow: View {
    
    var title = ""
    var time_ago = ""
    var imageURL = ""
    
    
    var body: some View {
        loadView()
    }
}

// MARK: UIView Extension
extension NotificationRow {
    
    func loadView() -> some View {
        HStack {
         
            AsyncImage(url: URL(string: imageURL)) { image in
                    image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .clipShape(Circle())

                } placeholder: {
                    Image(ImageName.mufti_placeHolder.rawValue)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(10)
                        .clipShape(Circle())
                }
            
            
            VStack(alignment: .leading) {
                Text("Skndr bkht sent you message")
                    .font(.custom(Popins.medium.rawValue, size: 12))
                Text("Just Now")
                    .font(.custom(Popins.regular.rawValue, size: 10))
            }
            
            Spacer()
            
            
        }.background(
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .shadow(radius: 1)
        ).padding([.leading, .trailing, .top])
    }
}


struct NotificationRow_Previews: PreviewProvider {
    static var previews: some View {
        NotificationRow()
    }
}
