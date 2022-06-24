//
//  ForgotEmailViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import Foundation

class ForgotEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var showError = false
    @Published var moveToOPTScreen = false
    
    var errorMessage = ""
}

extension ForgotEmailViewModel {
    
    func sendOTP(success: @escaping () -> Void) {
        if validationCheck() {
            
            sendOTPAPI {
                success()
            }
        }
    }
    
    
    private func validationCheck() -> Bool {
        
        if !Validator.shared.isValidEmail(email: email) {
            showError(message: "Email is not valid")
            return false
        }
        
        return true
        
    }
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }

    /// Network call
    private func sendOTPAPI(success: @escaping () -> Void) {

        let endPoint = "Users/forgot_password_email"
        
        let  parameters = [
            "email": email
        ]

        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: parameters, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponse = data as? GeneralResponse {
                
                if generalResponse.status == true {
                    // perform all user defaults handing coding here
                    self.moveToOPTScreen = true
//                    success()
                    
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
