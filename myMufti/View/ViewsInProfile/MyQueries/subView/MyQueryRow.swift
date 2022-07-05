//
//  MyQueryRow.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 21/06/2022.
//

import SwiftUI

struct MyQueryRow: View {
    
    var name = "Skndr bkht"
    var imageURL = ""
    var timeAgo = "Just Now"
    var message = "I want to give my Zakat to an Islamic Center, what should I do?"
    
    @Binding var query: MyQuery
    
    
    var body: some View {
        loadView()
    }
}

// MARK: - UIVIew extension
extension MyQueryRow {
    
    func loadView() -> some View {
        VStack {
            
            imageNameView()
            
            Text(query.questions)
                .font(.custom(Popins.regular.rawValue, size: 18))
                .padding(.bottom)
            
            acceptDeclineBtn()
        }
        .background(
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .shadow(radius: 1)
        ).padding([.leading, .trailing, .top])
    }
    
    func imageNameView() -> some View {
        HStack {
         
            
           AsyncImageMLB(url: URL(string: query.userID?.image ?? ""))
             .frame(width: 25, height: 25)
             .clipShape(Circle())
             .padding(10)
            
            Text(query.userID?.name ?? "")
                    .font(.custom(Popins.semiBold.rawValue, size: 12))
            
            Spacer()
            
            Text(query.timeago)
                .font(.custom(Popins.regular.rawValue, size: 8))
                .padding(10)
            
        }
    }
    
    func acceptDeclineBtn() -> some View {
        HStack(spacing: 0) {
            
            Button {
                print("accept")
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.green)
                        .frame(height: 50)
                        .cornerRadius(10, corners: [.bottomLeft])
                    
                    Text("Accept")
                        .foregroundColor(.white)
                        .font(.custom(Popins.bold.rawValue, size: 18))
                }
                
            }
            
            Button {
                print("Decline")
            } label: {
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(height: 50)
                        .cornerRadius(10, corners: [.bottomRight])
                    
                    Text("Decline")
                        .foregroundColor(.white)
                        .font(.custom(Popins.bold.rawValue, size: 18))
                    
                }
                
            }

        }
    }
    
    
}

struct MyQueryRow_Previews: PreviewProvider {
    static var previews: some View {
        MyQueryRow(query: .constant(MyQuery(id: "", userID: nil, date: "", muftiID: "", questions: "", category: "", createdAt: "", modified: "", status: "")))
    }
}
