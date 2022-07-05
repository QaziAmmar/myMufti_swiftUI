//
//  AskQuestionViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 27/06/2022.
//

import Foundation

class AskQuestionViewModel: ObservableObject {
    
    
    @Published var mufties = [Mufti]()
    @Published var searchText = ""
    @Published var question_detail = ""
    @Published var selectedCategory = ""
    //    @Published var selectedExperience = ""
    
    @Published var date = Date()
    // these variable will be pass to to filter view
    @Published var f_selectedCategory = ""
    @Published var f_selectedExperience = ""
    @Published var muftiId = ""
    
    @Published var showError = false
    var categories =  ["Family law" , "Finance" , "Home Finance" , "Marriage" , "Relationship" , "Dhikir" , "Duas" , "Raising kids" , "Parents" , "Salah" , "Dawah" , "Competitive religion" , "Comparative religion"]
    
    var errorMessage = ""
    
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    
    func fieldValidation() -> Bool {
        
        if question_detail.isEmpty {
            showError(message: "Please enter your question")
            return false
        }
        
        if !muftiId.isEmpty {
            return true
        }
        
        if f_selectedCategory.isEmpty && f_selectedExperience.isEmpty && selectedCategory.isEmpty {
            showError(message: "Please select category")
            return false
        }
        
        return true
        
    }
    
    func sendQuestion()  {
        if fieldValidation() {
            sendQuestionAPI()
        }
    }
    
    
    private func sendQuestionAPI() {
        
        if muftiId.isEmpty {
            if selectedCategory.isEmpty {
                showError(message: "Please select mufti from search")
            }
        } else {
            sendQuestionToAll(sendToAll: false)
            return
        }
        
        if f_selectedCategory.isEmpty && f_selectedExperience.isEmpty {
            sendQuestionToAll(sendToAll: true)
            return
        }
   
    }
    
    /// this function will reset the all variable to start value.
    func resetSereen()  {
        mufties = [Mufti]()
        searchText = ""
        question_detail = ""
        selectedCategory = ""
        
        date = Date()
        // these variable will be pass to to filter view
        f_selectedCategory = ""
        f_selectedExperience = ""
        muftiId = ""
    }
    
}


// MARK: - Network Extension
extension AskQuestionViewModel {
    
    func getAllMuftiesApi() {
        
        showAPILoader = false
        var endPoint = getEndPoint()
        
        endPoint = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .get, parametres: nil, returnType: MuftiModel.self) { data, statusCode in
            
            if let muftiesModel = data as? MuftiModel {
                
                if muftiesModel.status == true {
                    // perform all user defaults handing coding here
                    self.mufties = muftiesModel.mufties
                    showAPILoader = true
                } else {
                    self.mufties = []
                    //                    self.showError(message: muftiesModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
        
        // generate the url for get all mufties api
        func getEndPoint() -> String {
            var endPoint = "Users/searchMufti?mufti_name=\(searchText)"
            
            if !(f_selectedCategory.isEmpty) {
                endPoint += "&mufti_expertise=\(f_selectedCategory)"
            }
            
            if !(f_selectedExperience.isEmpty) {
                endPoint += "&mufti_experiance=\(f_selectedExperience)"
            }
            
            
            return endPoint
        }
    }
    
    private  func sendQuestionToAll(sendToAll: Bool) {
        
        
        var endPoint = ""
        var parameters = ["": ""]
        
        if muftiId.isEmpty {
            
            endPoint = "Users/questionForAllMufti"
            
            parameters = [
                "category" : selectedCategory,
                "question": question_detail,
                "startTime": DateManager.standard.getString(from: date),
                "endTime": "20:02:35"
            ]
            
        } else {
            endPoint = "Users/questionForMufti"
            
            parameters = [
                "user_id": UserDefaultManager.shared.userId,
                "mufti_id": muftiId,
                "question": question_detail,
                "startTime": DateManager.standard.getString(from: date),
                "endTime": "20:02:35"
            ]
        }
        
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: parameters, returnType: AskQuestionModel.self) { data, statusCode in
            
            if let askQuestionModel = data as? AskQuestionModel {
                
                if askQuestionModel.status == true {
                    // perform all user defaults handing coding here
                    self.resetSereen()
                    self.showError(message: askQuestionModel.message)
                    // change the tab to home
                } else {
                    self.showError(message: askQuestionModel.message)
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
        
    }
    
}
