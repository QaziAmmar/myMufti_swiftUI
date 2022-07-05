//
//  BecomeMuftiViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import Foundation

struct MuftiCategory: Identifiable {
    var id = UUID().uuidString
    var name = ""
    var isSelected = false
}

class BecomeMuftiViewModel: ObservableObject {
    
    @Published var showError = false
    @Published var moveToSuccess = false
    
    var name = ""
    var phone = ""
    var degreeName = ""
    var degreestartDate = ""
    var degreeendDate = ""
    var instituteName = ""
    var experienceFrom = ""
    var experienceTo = ""
    var degreeimage = ""
    
    @Published var categories = [MuftiCategory(name: "Family law", isSelected: false), MuftiCategory(name: "Finance", isSelected: false), MuftiCategory(name: "Marriage", isSelected: false),MuftiCategory(name: "Dhikir", isSelected: false),MuftiCategory(name: "Duas", isSelected: false),MuftiCategory(name: "Raising kids", isSelected: false),MuftiCategory(name: "Salah", isSelected: false),MuftiCategory(name: "Dawah", isSelected: false),MuftiCategory(name: "Competitive religion", isSelected: false),MuftiCategory(name: "Comparative religion")]
    
    
    var errorMessage = ""
}

extension BecomeMuftiViewModel {
    
  
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func callBecomeMuftiAPI() {
        
        if validationCheck() {
            becomeMuftiApi()
        }
    }
    
    func validationCheck() -> Bool {
        if getSelectedCategory().count == 0 {
            showError(message: "Please select atleast one category")
            return false
        }
        return true
    }
    
    func populateData(name: String, phone: String, degreeName: String, degreestartDate: String, degreeendDate: String, instituteName: String, experienceFrom: String, experienceTo: String, degreeimage: String) {
        self.name = name
        self.phone = phone
        self.degreeName = degreeName
        self.degreestartDate = degreestartDate
        self.degreeendDate = degreeendDate
        self.instituteName = instituteName
        self.experienceFrom = experienceFrom
        self.experienceTo = experienceTo
        self.degreeimage = degreeimage
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
    
    
    private func becomeMuftiApi() {
        let endPoint = "Users/mufti"
        
        let perameters = [
            "user_id": UserDefaultManager.shared.userId,
                "name": name,
                "phone": phone,
                "degree": degreeName,
                "degree_image": degreeimage,
                "degree_start_date": degreestartDate,
                "degree_end_date": degreeendDate,
                "institute_name": instituteName,
                "experiance_from": experienceFrom,
                "experiance_to": experienceTo,
                "expertise": getSelectedCategory()
            
        ] as [String : Any]
        
        
        NetworkManager.shared.URLrequest(endPointURL: endPoint, methodType: .post, parametres: perameters, returnType: GeneralResponse.self) { data, statusCode in
            //
            if let generalResponse = data as? GeneralResponse {
                
                if generalResponse.status == true {
                    print("login success")
                    // perform all user defaults handing coding here
                    DispatchQueue.main.async {
                        self.moveToSuccess = true
                    }
                    
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
