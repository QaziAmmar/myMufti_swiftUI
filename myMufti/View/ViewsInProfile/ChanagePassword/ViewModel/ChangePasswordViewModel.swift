//
//  ChangePasswordViewModel.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 10/03/2022.
//


import Foundation

class ChangePasswordViewModel: ObservableObject {
    
    @Published var old_password = UserDefaultManager.shared.password
    
    @Published var password = ""
    @Published var retype_password = ""
    @Published var showError = false
    
    var errorMessage = ""
    
    
}

extension ChangePasswordViewModel {
    
    func changePassword(passwordChangeSuccess: @escaping (() -> Void)) {
        
        if passwordValidation() {
            callNetworkApi(success: passwordChangeSuccess)
        }
        
    }
    
    // perform all validation check on the fields
    func passwordValidation() -> Bool {
        let saved_oldPassword = UserDefaultManager.shared.get()?.password

        if old_password.isEmpty || password.isEmpty || retype_password.isEmpty {
            showError(message: "Please fill all the fields")
            return false
        }
        
        if old_password.count < 6 || password.count < 6 || retype_password.count < 6 {
            showError(message: "Please enter atleast 6 character for password")
            return false
        }

        if saved_oldPassword != old_password {
            showError(message: "Old passowrd is not matched")
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
    func callNetworkApi(success: @escaping (() -> Void)) {
        
        let endPoint = "Users/change_password"
        let user_id = (UserDefaultManager.shared.get()?.id)!
        
        let parameters = [
            "password": password,
            "user_id": String(user_id)
        ]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .put, parametres: parameters, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponse = data as? GeneralResponse {
                
                if generalResponse.status == true {
                    UserDefaultManager.shared.update(password: self.password)
                    success()
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
