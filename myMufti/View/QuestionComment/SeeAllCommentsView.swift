//
//  SeeAllCommentsView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 06/07/2022.
//

import SwiftUI

struct SeeAllCommentsView: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var comments = [Comment]()
    
    var body: some View {
        loadView()
    }
}



extension SeeAllCommentsView {

    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Comments")
            commentList()
        }
        
        
    }
    
    func commentList() -> some View {
        
        ScrollView(.vertical ,showsIndicators : false) {
                ForEach(comments.indices, id: \.self) { index in
                    CommentRow(comment: comments[index])
                        .id(index)
                }
                
        }.padding()

    }
}

struct SeeAllCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllCommentsView()
    }
}
