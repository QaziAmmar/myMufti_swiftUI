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
    
}
