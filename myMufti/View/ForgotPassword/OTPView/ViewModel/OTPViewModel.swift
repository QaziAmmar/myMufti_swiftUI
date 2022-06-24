//
//  OTPViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import Foundation


class OTPViewModel: ObservableObject {
    

    @Published var otpCode = ""
    @Published var movetoCreateNewPassword = false
    var userId = String()
    @Published var showError = false
    
    
    var errorMessage = ""
}

extension OTPViewModel {
    
    func sendOTP(at email: String) {
        callOTPApi(email: email)
    }
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }

    /// Network call
    private func callOTPApi(email: String) {

        let endPoint = "Users/check_code"
        
        let  parameters = [
            "email": email,
            "code": otpCode
        ]

        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: parameters, returnType: UserModel.self) { data, statusCode in
            
            if let userModel = data as? UserModel {
                
                if userModel.status == true {
                    // perform all user defaults handing coding here
                    DispatchQueue.main.async {
                        self.userId = userModel.data?.id ?? ""
                        self.movetoCreateNewPassword = true
                    }
                    
                } else {
                    self.errorMessage = userModel.message
                    self.showError = true
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
        }
    }
}
