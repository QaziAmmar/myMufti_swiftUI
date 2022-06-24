//
//  CreateNewPasswordViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import Foundation
//CreateNewPasswordViewModel


import Foundation

class CreateNewPasswordViewModel: ObservableObject {

    @Published var password = ""
    @Published var retype_password = ""
    @Published var showError = false
    
    var errorMessage = ""
    
    
}

extension CreateNewPasswordViewModel {
    
    func changePassword(userId: String) {
        
        if passwordValidation() {
            callNetworkApi(user_id: userId)
        }
        
    }
    
    // perform all validation check on the fields
    func passwordValidation() -> Bool {
        
        if password.isEmpty || retype_password.isEmpty {
            showError(message: "Please fill all the fields")
            return false
        }
        
        if  password.count < 6 || retype_password.count < 6 {
            showError(message: "Please enter atleast 6 character for password")
            return false
        }
        if password != retype_password {
            showError(message: "Password and retype password does not matched")
            return false
        }

        return true
        
    }
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    // call network api for sending the request.
    func callNetworkApi(user_id: String) {
        
        let endPoint = "Users/change_password"
        
        let parameters = [
            "password": password,
            "user_id": String(user_id)
        ]
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .put, parametres: parameters, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponse = data as? GeneralResponse {
                
                if generalResponse.status == true {
                    
                    // this will move use back to login view
                    print("passowrd change successfully")
                    UserDefaultManager.moveToLogin.send(false)
                    
                } else {
                    self.errorMessage = generalResponse.message
                    self.showError = true
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
        
    }
    
    
}
