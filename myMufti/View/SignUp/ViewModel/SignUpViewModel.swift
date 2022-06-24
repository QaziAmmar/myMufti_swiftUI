//
//  SignUpViewModel.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 18/03/2022.
//

import Foundation


class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var retypePassword = ""
    @Published var userName = ""
    @Published var showError = false
    var errorMessage = ""
}

extension SignUpViewModel {
    
    func SignUpUser() {
        
        if validationCheck() {
            callNetworkApi()
        }
        
    }
    
    private func validationCheck() -> Bool {
        
        if password.isEmpty || userName.isEmpty || email.isEmpty || retypePassword.isEmpty {
            showError(message: "Please fill all the fields")
            return false
        }
        
        if password.count < 6 {
            showError(message: "Password must be at least 6 characters")
            return false
        }
        
        if !Validator.shared.isValidEmail(email: email) {
            showError(message: "Email is not valid")
            return false
        }
        
        if password != retypePassword {
            showError(message: "Password and retype password does not match")
            return false
        }
        
        return true
        
    }
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    
    private func callNetworkApi() {
        let endPoint = "Users/user"

        let perameters = [
            "name": userName,
            "email": email,
            "fireBase_id" : "1212212",
            "password": password
            
        ]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: perameters, returnType: UserModel.self) { data, statusCode in
            //
            if let userModel = data as? UserModel, var user: User = userModel.data {
                
                if userModel.status == true {
                    print("login success")
                    // perform all user defaults handing coding here
                    user.password = self.password
                    //
                    UserDefaultManager.shared.set(user: user)
                    // this is a broadCast object that is used to switch the on login screen
                    UserDefaultManager.Authenticated.send(true)
                    
                } else {
                    self.errorMessage = userModel.message ?? ""
                    self.showError = true
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
        
        
    }
}
