//
//  GsignInViewModel.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 18/03/2022.
//

import Foundation
import SwiftUI
import GoogleSignIn

class GSignInViewModel: ObservableObject {
    
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
//    init(){
//        check()
//    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            print(user)
            guard let user = user else { return }
            let givenName = user.profile?.givenName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.profilePicUrl = profilePicUrl
            self.isLoggedIn = true
            
            callNetworkApi(user: user)
            
        } else {
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl =  ""
            print("Not Logged In")
        }
    }
    
//    func check(){
//        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//            if let error = error {
//                self.errorMessage = "error: \(error.localizedDescription)"
//            }
//            
//            self.checkStatus()
//        }
//    }
    
    func signIn(){
        
       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        let signInConfig = GIDConfiguration.init(clientID: "1052712632545-79pbdbnm6guo4809or4c69kv8q19puf8.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController,
            callback: { user, error in
                if let error = error {
                    self.errorMessage = "error: \(error.localizedDescription)"
                }
                self.checkStatus()
            }
        )
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}


extension GSignInViewModel {
    private func callNetworkApi(user: GIDGoogleUser) {
            
            let endPoint = "socialLogin"
        
        
        guard let token = user.authentication.idToken else {
            print("Google SignIn Token is Empty")
            return
        }
        
        let parameters: [String: String] = [
            "email": user.profile?.email ?? "",
            "g_token": token
        ]

            
            NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: parameters, returnType: UserModel.self) { data, statusCode in
                
                if let userModel = data as? UserModel, var user: User = userModel.data {
                    
                    if userModel.status == true {
                        print("Social Login success")
                        // perform all user defaults handing coding here
//                        user.isSocialUser = true
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
