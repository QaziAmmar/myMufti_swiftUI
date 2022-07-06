//
//  CommentRow.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import SwiftUI

struct CommentRow: View {

    var comment: Comment
    
    var body: some View {
        
            loadView()
         
    }
}


// MARK: - View Extension
extension CommentRow {
    func loadView() -> some View {
        HStack {
            AsyncImageMLB(url: URL(string: comment.userID?.image ?? ""))
                .frame(width: 40, height: 40)
                

            ZStack {
                Rectangle()
                    .frame(height: 46)
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight, .topRight])
                    .foregroundColor(.white)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(comment.userID?.name ?? "")
                            .font(.custom(Popins.medium.rawValue, size: 11))
                        Text(comment.comment)
                            .font(.custom(Popins.regular.rawValue, size: 8))
                    }
                    
                    Spacer()
                    
                    Text(DateManager.standard.timeAgoDisplay(from: comment.createdAt))
                        .foregroundColor(.gray)
                        .font(.custom(Popins.medium.rawValue, size: 10))
                    
                }.padding(7)
            }
                
            
        }
        
    }
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow(comment: Comment(commentID: "", questionID: "", userID: UserID(image: "", id: "", name: ""), comment: "", createdAt: ""))
    }
}
