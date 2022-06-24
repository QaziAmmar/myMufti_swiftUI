//
//  AskMuftiViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import Foundation

class AskMuftiViewModel: ObservableObject {
    
    
    @Published var mufties = [Mufti]()
    @Published var searchText = ""
    @Published var showError = false
    var errorMessage = ""
    
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
}


// MARK: - Network Extension
extension AskMuftiViewModel {
    
     func getAllMuftiesApi() {

        let endPoint = "Users/mufti"

        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .get, parametres: nil, returnType: MuftiModel.self) { data, statusCode in
            
            if let muftiesModel = data as? MuftiModel {
                
                if muftiesModel.status == true {
                    // perform all user defaults handing coding here
                    self.mufties = muftiesModel.mufties
                    
                } else {
                    self.showError(message: muftiesModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
    }
}
