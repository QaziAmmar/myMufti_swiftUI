//
//  HelpViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import Foundation

class HelpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var description = ""
    @Published var showError = false
    
    var errorMessage = ""
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func sendHelpEmail() {
        
        if fieldsValidation() {
            // call network api
//            callHelpApi()
        }
    }
    
    func fieldsValidation() -> Bool  {
        if email.isEmpty || description.isEmpty {
            showError(message: "Please fill all the fields")
            return false
        }
        return true
    }

}

// MARK: - Network Extension
extension HelpViewModel {
    
     func callHelpApi() {
        
        let user_id = UserDefaultManager.shared.userId
        let endPoint = "Users/meetings?id=" + user_id
         

        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .get, parametres: nil, returnType: GeneralResponse.self) { data, statusCode in
            
            if let meetingModel = data as? GeneralResponse {
                
                self.showError(message: meetingModel.message)
                
//                if meetingModel.status == true {
//                    // perform all user defaults handing coding here
//                    self.showError(message: meetingModel.message)
//                } else {
//                    self.showError(message: meetingModel.message)
//                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
    }
    
}
