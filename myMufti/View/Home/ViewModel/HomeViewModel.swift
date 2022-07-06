//
//  HomeViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 29/06/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var showError = false
    @Published var questions = [QuestionModel]()
    
    var errorMessage = ""
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
}


extension HomeViewModel {
    
    func getAllMuftiesApi() {
        
        
        var endPoint = "Users/dashboard"
        
        endPoint = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .get, parametres: nil, returnType: HomeModel.self) { data, statusCode in
            
            if let homeModel = data as? HomeModel {
                
                if homeModel.status == true {
                    // perform all user defaults handing coding here
                    self.questions = homeModel.data
                } else {
                    self.showError(message: homeModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString 
        }
    }
    
    func userVoteForQuestion(question_index: Int, vote: String) {
        
        let endPoint = "Users/vote"
        
        let parameters = [
            "user_id": UserDefaultManager.shared.userId,
            "question_id": questions[question_index].questionID,
               "vote": vote
        ]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: parameters, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponseModel = data as? GeneralResponse {
                
                if generalResponseModel.status == true {
                    // perform all user defaults handing coding here
                    // disable comment button for user
                    self.questions[question_index].voteDisable = true
                } else {
                    self.showError(message: generalResponseModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
        }
    }
    
    
}
