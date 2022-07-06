//
//  MyQueriesViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 21/06/2022.
//

import Foundation


class MyQueriesViewModel: ObservableObject {
    
    
    @Published var myQueries = [MyQuery]()
    @Published var showError = false
    var errorMessage = ""
    
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
}


// MARK: - Network Extension
extension MyQueriesViewModel {
    
    
    private func removeQuery(query: MyQuery) {
        if let index = myQueries.firstIndex(of: query) {
            myQueries.remove(at: index)
        }
    }
    
    
    func callMyQueryAPI() {
        
        let user_id = UserDefaultManager.shared.userId
        let endPoint = "Users/myQueries?" + user_id
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .get, parametres: nil, returnType: MyQueryModel.self) { data, statusCode in
            
            if let myqueryModel = data as? MyQueryModel {
                
                if myqueryModel.status == true {
                    // perform all user defaults handing coding here
                    self.myQueries = myqueryModel.data
                    
                } else {
                    self.showError(message: myqueryModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
    }
    
    
    
    func postQuestionStatusAPI(question: MyQuery, status: Bool) {
        
        let user_id = UserDefaultManager.shared.userId
        let endPoint = "Users/questionStatus"
        
        let parameters = [
            "ques_id" :  question.id!,
            "user_id" : user_id,
            "mufti_id"  : question.muftiID,
            "status" : (status == true ? 1 : 0)
        ] as [String : Any]
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .put, parametres: parameters, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponse = data as? GeneralResponse {
                
                if generalResponse.status == true {
                    // perform all user defaults handing coding here
                    print("success")
                    self.removeQuery(query: question)
                } else {
                    self.showError(message: generalResponse.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
    }
    
    
}
