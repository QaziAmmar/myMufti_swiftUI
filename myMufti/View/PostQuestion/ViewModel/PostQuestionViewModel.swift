//
//  PostQuestionViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import Foundation


class PostQuestionViewModel: ObservableObject {
    
    
    @Published var showError = false
    @Published var moveToSuccess = false
    
    @Published var question_detail  = ""
    @Published var votingOption: VotingOption = .none
    
    
    // Time PickerView Variable
    var data: [[String]] = [
        Array(0...23).map { "\($0)" },
        Array(0...59).map { "\($0)" },
        Array(0...59).map { "\($0)" }
    ]
    
    @Published var selections: [Int] = [0, 0, 0]
    
    
    @Published var categories = [MuftiCategory(name: "Family law", isSelected: false), MuftiCategory(name: "Finance", isSelected: false), MuftiCategory(name: "Marriage", isSelected: false),MuftiCategory(name: "Dhikir", isSelected: false),MuftiCategory(name: "Duas", isSelected: false),MuftiCategory(name: "Raising kids", isSelected: false),MuftiCategory(name: "Salah", isSelected: false),MuftiCategory(name: "Dawah", isSelected: false),MuftiCategory(name: "Competitive religion", isSelected: false),MuftiCategory(name: "Comparative religion")]
    
    
    var errorMessage = ""
}

extension PostQuestionViewModel {
    
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func postQuestion() {
        
        if validationCheck() {
            
            postQuestionAPI()
        }
    }
    
    func validationCheck() -> Bool {
        
        if question_detail.isEmpty {
            showError(message: "Please enter question detail")
            return false
        }
        
        if votingOption == .none {
            showError(message: "Please select Voting type")
            return false
        }
        
        if getSelectedCategory().count == 0 {
            showError(message: "Please select atleast one category")
            return false
        }
        // 0 => hr
        // 1 => min
        // 2 => sec
        if (getTimeLimit().0 == "0" &&  getTimeLimit().1 == "0" && getTimeLimit().2 == "0" ) {
            showError(message: "Please select time limit")
            return false
        }
        
        
        return true
    }
    
    
    
    // this block of code is use to get the seleted category of muftis
    func getSelectedCategory() -> [String]{
        
        var selectedCategory = [String]()
        
        for category in categories {
            if category.isSelected {
                selectedCategory.append(category.name)
            }
        }
        
        return selectedCategory
    }
    
    // get hr, minutes and sec from time limit.
    func getTimeLimit() -> (String, String, String) {
        
        return (data[0][selections[0]], data[1][selections[1]], data[2][selections[2]])
        
    }
    
    
    private func postQuestionAPI() {
        let endPoint = "Users/question"

        let perameters = [
            "user_id": UserDefaultManager.shared.userId,
            "question_title": "Question",
            "question": question_detail,
            "options": votingOption.rawValue,
            "current_time": DateManager.standard.getString(from: Date()),
            "time_limit": "\(getTimeLimit().0):\(getTimeLimit().1):\(getTimeLimit().2)",
            "categories": getSelectedCategory()
            
        ] as [String : Any]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: perameters, returnType: GeneralResponse.self) { data, statusCode in
            //
            if let postQuestionModel = data as? GeneralResponse {
                
                if postQuestionModel.status == true {
                    // perform all user defaults handing coding here
                    self.moveToSuccess = true
                } else {
                    self.errorMessage = postQuestionModel.message
                    self.showError = true
                }
            }
            
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
    }
}
