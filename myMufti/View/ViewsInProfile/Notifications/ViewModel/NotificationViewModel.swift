//
//  NotificationViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 21/06/2022.
//

import Foundation


class NotificationViewModel: ObservableObject {
    
    @Published var showError = false
    
    var errorMessage = ""
}


// MARK: - Network Extension
extension NotificationViewModel {
    
    private func changeUserNameAPI(success: @escaping () -> Void) {
        
        
        let endPoint = "Users/change_password"
        
        let parameters = [ "user_id": String(UserDefaultManager.shared.userId)]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .put, parametres: parameters, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponse = data as? GeneralResponse {
                
                if generalResponse.status == true {
                    // perform all user defaults handing coding here
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
