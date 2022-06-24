//
//  HistoryViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    
    @Published var history_array = [History]()
    @Published var showError = false
    var errorMessage = ""
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
}


// MARK: - Network Extension
extension HistoryViewModel {
    
     func historyApi() {
        
        let user_id = UserDefaultManager.shared.userId
        let endPoint = "Users/meetings?id=" + user_id
         

        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .get, parametres: nil, returnType: HistoryModel.self) { data, statusCode in
            
            if let historyModel = data as? HistoryModel {
                
                if historyModel.status == true {
                    // perform all user defaults handing coding here
                    self.history_array = historyModel.histories
                    
                } else {
                    self.showError(message: historyModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
    }
    
}
