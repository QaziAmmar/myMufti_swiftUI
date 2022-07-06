//
//  QuestionCommentViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import Foundation


class QuestionCommentViewModel: ObservableObject {
    
    @Published var showError = false
    @Published var comments = [Comment]()
    
    @Published var muftiAnswer = ""
    @Published var userComment = ""
    
    var errorMessage = ""
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
}


extension QuestionCommentViewModel {
    
    func getCommentsOf(question_id: String) {
        
        
        var endPoint = "Users/comment?question_id=\(question_id)"
        
        endPoint = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .get, parametres: nil, returnType: CommentModel.self) { data, statusCode in
            
            if let commentModel = data as? CommentModel {
                
                if commentModel.status == true {
                    // perform all user defaults handing coding here
                    self.comments = commentModel.comments
                } else {
                    self.showError(message: commentModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
        }
    }
    
    func postCommentApi(question_id: String) {
        
        if userComment.isEmpty {
            return
        }
        
        let endPoint = "Users/comment"
        
        let parametres = [
            "user_id": UserDefaultManager.shared.userId,
                "question_id": question_id,
                "comment": userComment
            
        ]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: parametres, returnType: PostCommentModel.self) { data, statusCode in
            
            if let postCommentModel = data as? PostCommentModel {
                
                if postCommentModel.status == true {
                    // perform all user defaults handing coding here
                    self.userComment = ""
                    self.comments.append(postCommentModel.comment)
                } else {
                    self.showError(message: postCommentModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
        }
    }
    
    
    
    func muftiAnswer(question_id: String, success: @escaping () -> Void) {
        
        if muftiAnswer.isEmpty {
            return
        }
        // testing
        
        let endPoint = "Users/answer"
        
        let parametres = [
            "mufti_id": UserDefaultManager.shared.userId,
             "question_id": question_id,
             "answer": muftiAnswer
        ]

        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: parametres, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponseModel = data as? GeneralResponse {
                
                if generalResponseModel.status == true {
                    // perform all user defaults handing coding here
                    success()
                } else {
                    self.showError(message: generalResponseModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
        }
    }
    
    
}
