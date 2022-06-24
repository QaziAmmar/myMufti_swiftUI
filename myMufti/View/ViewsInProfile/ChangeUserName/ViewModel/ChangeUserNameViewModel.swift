//
//  ChangeUserNameViewModel.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 10/03/2022.
//

import Foundation

class ChangeUserNameViewModel: ObservableObject {
    
    @Published var username = UserDefaultManager.shared.userName
    @Published var showError = false
    
    var errorMessage = ""
}

extension ChangeUserNameViewModel {
    
    
    func chnageUsername(success: @escaping () -> Void ) {
        
        if username == "" {
            errorMessage = "Username cannot be empty"
            showError = true
            
        } else {
            
            changeUserNameAPI {
                success()
            }
        }
    }
    
    
    private func changeUserNameAPI(success: @escaping () -> Void) {
        
        
        let endPoint = "Users/change_password"
        
        let parameters = [ "user_id": String(UserDefaultManager.shared.userId),
                           "password": username]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .put, parametres: parameters, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponse = data as? GeneralResponse {
                
                if generalResponse.status == true {
                    // perform all user defaults handing coding here
                    UserDefaultManager.shared.update(name: self.username)
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
