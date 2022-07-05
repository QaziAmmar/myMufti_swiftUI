//
//  AskQuestionModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 29/06/2022.
//

import Foundation


// MARK: - Welcome
struct AskQuestionModel: Codable {
    let status: Bool
    let message: String
    let data: AskQuestion
}

// MARK: - DataClass
struct AskQuestion: Codable {
    let quesID, userID, muftiID, questions: String
    let category, startTime, endTime, createdAt: String
    let modified, status: String

    enum CodingKeys: String, CodingKey {
        case quesID = "ques_id"
        case userID = "user_id"
        case muftiID = "mufti_id"
        case questions, category, startTime, endTime
        case createdAt = "created_at"
        case modified, status
    }
}
