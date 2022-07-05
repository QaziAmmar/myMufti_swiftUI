//
//  UserDefaultManager.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 03/03/2022.
//

import Foundation
import Combine
import SwiftUI

enum UserDefaultEnum: String {
    case token
    case username
    case password
    case picture
    case userModel
    case isSplashOpened
}


class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    let userDefaults : UserDefaults = UserDefaults.standard
    
    // this will return the empty stirng if no value is founded into UserDefaults.
    var userId: String {
        return UserDefaultManager.shared.get()?.id ?? ""
    }
    // this will return the empty stirng if no value is founded into UserDefaults.
    var userName: String {
        return UserDefaultManager.shared.get()?.name ?? ""
    }
    // return the saved password into the UserDefaults
    var password: String {
        return userDefaults.string(forKey: UserDefaultEnum.password.rawValue) ?? ""
    }
    // return the saved password into the UserDefaults
    var userImg: String {
        return NetworkManager.mediaURL + (UserDefaultManager.shared.get()?.image ?? "")
    }
    
    var isSplashOpen: Bool {
        return (UserDefaultManager.shared.userDefaults.value(forKey: UserDefaultEnum.isSplashOpened.rawValue) as? Bool) ?? false
        
    }
    

    static let Authenticated = PassthroughSubject<Bool, Never>()
    static let moveToLogin = PassthroughSubject<Bool, Never>()
    static let muftiSuccess = PassthroughSubject<Bool, Never>()
    static let changeTab = PassthroughSubject<Int, Never>()
    
    static func IsAuthenticated() -> Bool {
        //this means that userDefaults have some data
        return shared.get() != nil
    }
    
    /// save user object into userDefaults
    func set(user: User) {
        // save complete userModel object into user Default.
        // structures cannot save into userDefaults so we need to convert them into
        // data before saving into usersDefaults.
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            userDefaults.set(encoded, forKey: UserDefaultEnum.userModel.rawValue)
        }

    }
    
    /// get the whole userObject form userDefaults.
    func get() -> User? {
   
        if let userData: Data =  userDefaults.object(forKey: UserDefaultEnum.userModel.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: userData) {
                return user
            }
            print("User Decoder Error")
        }
        print("User Not Found in UsersDefaults")
        return nil
    }
    
    /// Update username and save the new value into userDefaults
    func update(name: String) {
        var user = self.get()
        user?.name = name
        self.set(user: user!)
    }
//
//    /// Update password and save the new value into userDefaults
    func update(password: String) {
        var user = self.get()
        user?.password = password
        self.set(user: user!)
    }
//
//    /// Update the Image url
//    func update(imageURL: String) {
//        var user = self.get()
//        user?.image = imageURL
//        self.set(user: user!)
//    }
    
    /// Remove all the user infor from the userDefault
    func removeUser() {
        userDefaults.removeObject(forKey: UserDefaultEnum.userModel.rawValue)
        UserDefaultManager.Authenticated.send(false)
    }

}

