import Foundation
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {

    
    @Published var username = UserDefaultManager.shared.userName
    @Published var userImg = UserDefaultManager.shared.userImg
    @Published var password = ""
    @Published var showError = false
    
    
    var errorMessage = ""
    
    
    func logoutUser() {
        UserDefaultManager.shared.removeUser()
    }
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func chnageUsername(success: @escaping () -> Void ) {
        
        if username == "" {
            showError(message: "Username can not be empty")
        } else {
            
            changeUserNameAPI {
                success()
            }
        }
    }
    
}


extension ProfileViewModel {
    
    private func changeUserNameAPI(success: @escaping () -> Void) {

        let endPoint = "changeUsername"
        
        let parameters = [ "userId": String(UserDefaultManager.shared.userId),
                           "username": username]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .put, parametres: parameters, returnType: GeneralResponse.self) { data, statusCode in
            
            if let generalResponse = data as? GeneralResponse {
                
                if generalResponse.status == true {
                    // perform all user defaults handing coding here
//                    UserDefaultManager.shared.update(name: self.username)
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
    
    func updateImage(image: UIImage) {

    let endPoint = "changeUserImage"
    
    let parameters = [ "userId": String(UserDefaultManager.shared.userId),
                        "base64Img": getBase64String(from: image)]
    
    
//    NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .put, parametres: parameters, returnType: UpdateImageModel.self) { data, statusCode in
//
//        if let UpdateImgModel = data as? UpdateImageModel {
//
//            if UpdateImgModel.status == true {
//                // perform all user defaults handing coding here
//                UserDefaultManager.shared.update(imageURL: UpdateImgModel.data.image)
//                self.userImg = NetworkManager.mediaURL + UpdateImgModel.data.image
//
//            } else {
//                self.errorMessage = UpdateImgModel.message
//                self.showError = true
//            }
//        }
//
//    } withapiFiluer: { errorString in
//        self.errorMessage = errorString
//
//    }
}
    
}



