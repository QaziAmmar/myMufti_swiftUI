//
//  FilterViewModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 27/06/2022.
//

import Foundation


class FilterViewModel: ObservableObject {
    
    @Published var showError = false
    var experience =  ["1 Year" ,"2 Years" ,"3 Years" ,"4 Years" ,"5 Years" ,"6 Years" ,"7 Years" ,"8 Years" ,"9 Years" ,"10 Years"]
    
    var categories =  ["Family law" , "Finance" , "Home Finance" , "Marriage" , "Relationship" , "Dhikir" , "Duas" , "Raising kids" , "Parents" , "Salah" , "Dawah" , "Competitive religion" , "Comparative religion"]
    
    var errorMessage = ""
    
    
    
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
}

