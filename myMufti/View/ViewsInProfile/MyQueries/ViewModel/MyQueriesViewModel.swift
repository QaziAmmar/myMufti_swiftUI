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
    
}
