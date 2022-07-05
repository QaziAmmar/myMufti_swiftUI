//
//  MuftiModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//



import Foundation

// MARK: - Welcome
struct MuftiModel: Codable {
    let status: Bool
    let message: String
    let mufties: [Mufti]
    enum CodingKeys: String, CodingKey {
        case status, message
        case mufties = "data"
    }
    
}

// MARK: - Datum
struct Mufti: Codable, Identifiable {
    let id, name, email, password: String
    let phoneNumber, image, status, createdAt: String
    
    var user_img: AsyncImageMLB {
        AsyncImageMLB(url: URL(string: NetworkManager.mediaURL + image))
    }
    
    let modified, code, fCode: String
    let gToken: String
    let fbToken, aCode, nationality: String
    let userType: String
    let degree: String
    let degreeImage: String
    let degreeStartDate, degreeEndDate, instituteName, experianceFrom: String
    let experianceTo, totalExperiance, shopRegistered, emailCode: String
    let fireBaseID: String
    let muftiExpertise: [MuftiExpertise]
    
    var experties: String {
        var returnValue = ""
        muftiExpertise.forEach({ mufti in
            returnValue = returnValue + mufti.expertise + ","
        })
        return returnValue
    }

    enum CodingKeys: String, CodingKey {
        case id, name, email, password
        case phoneNumber = "phone_number"
        case image, status
        case createdAt = "created_at"
        case modified, code
        case fCode = "f_code"
        case gToken = "g_token"
        case fbToken = "fb_token"
        case aCode = "a_code"
        case nationality
        case userType = "user_type"
        case degree
        case degreeImage = "degree_image"
        case degreeStartDate = "degree_start_date"
        case degreeEndDate = "degree_end_date"
        case instituteName = "institute_name"
        case experianceFrom = "experiance_from"
        case experianceTo = "experiance_to"
        case totalExperiance = "total_experiance"
        case shopRegistered = "shop_registered"
        case emailCode = "email_code"
        case fireBaseID = "fireBase_id"
        case muftiExpertise = "mufti_expertise"
    }
}


// MARK: - MuftiExpertise
struct MuftiExpertise: Codable {
    let id, userID, expertise: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case expertise
    }
}

