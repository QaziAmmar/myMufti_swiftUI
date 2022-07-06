//
//  HomeModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 01/07/2022.
//

import Foundation
// MARK: - Welcome
struct HomeModel: Codable {
    let status: Bool
    let message: String
    let data: [QuestionModel]
}

// MARK: - Datum
struct QuestionModel: Codable, Identifiable {
    let id = UUID().uuidString
    let questionID: String
    let userID: UserID
    let questionTitle: String
    let question, options, timeLimit, createdAt: String
    let userVote, muftiAnswer: String
    let questionCategories: [QuestionCategory]
    let questionComment, totalVote, totalVoteForYes, totalVoteForNo: Int
    
    var voteDisable: Bool? = false
    var openToAnswer: Bool? = true
    
    
    var createAgo: String {
        DateManager.standard.timeAgoDisplay(from: createdAt)
    }
    
    var timeRemaining: String {
        DateManager.standard.timeAgoDisplay(from: timeLimit).replacingOccurrences(of: "in", with: "")
    }
    
    var yesPercentage: String {
       let yesPercentage = (Double(totalVoteForYes) / Double(totalVote)) * 100
        if yesPercentage.isNaN {
            return "0 %"
        } else {
            return "\(yesPercentage.cleanValue) %"
        }
        
    }
    
    var noPercentage: String {
       let noPercentage = (Double(totalVoteForNo) / Double(totalVote)) * 100
       
        if noPercentage.isNaN {
            return "0 %"
        } else {
            
            return "\(noPercentage.cleanValue) %"
        }
    }
    
    var yesNormilized: Double {
        let yesPercentage = (Double(totalVoteForYes) / Double(totalVote))
        if yesPercentage.isNaN {
            return 0.0
        } else {
            return (yesPercentage * 0.75)
        }
    }
    
    var noNormilized: Double {
        let noPercentage = (Double(totalVoteForNo) / Double(totalVote))
        if noPercentage.isNaN {
            return 0.0
        } else {
            return (noPercentage * 0.75)
        }
    }
    

    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case userID = "user_id"
        case questionTitle = "question_title"
        case question, options
        case timeLimit = "time_limit"
        case createdAt = "created_at"
        case userVote = "user_vote"
        case muftiAnswer = "mufti_answer"
        case questionCategories = "question_categories"
        case questionComment = "question_comment"
        case totalVote = "total_vote"
        case totalVoteForYes = "total_vote_for_yes"
        case totalVoteForNo = "total_vote_for_no"
    }
}

// MARK: - QuestionCategory
struct QuestionCategory: Codable {
    let id, questionID, categories: String

    enum CodingKeys: String, CodingKey {
        case id
        case questionID = "question_id"
        case categories
    }
}

extension Double {
    var cleanValue: String {
           return String(format: "%.0f", self)
       }
}
