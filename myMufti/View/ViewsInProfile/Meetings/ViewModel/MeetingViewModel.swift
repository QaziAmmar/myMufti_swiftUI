//
//  MeetingViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import Foundation


class MeetingViewModel: ObservableObject {
    
    
    @Published var meetings = [Meeting]()
    @Published var showError = false
    var errorMessage = ""
    
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
}


// MARK: - Network Extension
extension MeetingViewModel {
    
     func callMyMeetingAPI() {
        
        let user_id = UserDefaultManager.shared.userId
//        let endPoint = "Users/meetings?id=" + user_id
         let endPoint = "Users/meetings?id=" + "152"

        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .get, parametres: nil, returnType: MeetingModel.self) { data, statusCode in
            
            if let meetingModel = data as? MeetingModel {
                
                if meetingModel.status == true {
                    // perform all user defaults handing coding here
                    
                    self.meetings = meetingModel.meetings
                    
                } else {
                    self.showError(message: meetingModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
    }
    
}
