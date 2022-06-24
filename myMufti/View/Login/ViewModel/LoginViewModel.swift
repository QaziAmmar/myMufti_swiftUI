import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showError = false
    var errorMessage = ""
}

extension LoginViewModel {
    
    func loginUser() {
        if validationCheck() {
            callNetworkApi()
        }
    }
    
    
    private func validationCheck() -> Bool {
        
        if password.isEmpty || email.isEmpty {
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
        
        return true
        
    }
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }

    /// Network call
    private func callNetworkApi() {
        
        let endPoint = "Users/login"
        let  parameters = [
            "email": email,
            "password": password
        ]
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: parameters, returnType: UserModel.self) { data, statusCode in
            
            if let userModel = data as? UserModel, var user: User = userModel.data {
                
                if userModel.status == true {
                    // perform all user defaults handing coding here
                    // saving this for change password Screen
                    user.password = self.password
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
