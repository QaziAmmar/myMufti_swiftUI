//
//  PostQuestionModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import Foundation

// MARK: - Welcome
struct PostQuestionModel: Codable {
    let status: Bool
    let message: String
    let data: PostQuestion
}

// MARK: - DataClass
struct PostQuestion: Codable {
    let questionID, userID, questionTitle, question: String
    let options, timeLimit, createdAt: String
    let questionCategories: [QuestionCategory]
    let questionComment: Int

    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case userID = "user_id"
        case questionTitle = "question_title"
        case question, options
        case timeLimit = "time_limit"
        case createdAt = "created_at"
        case questionCategories = "question_categories"
        case questionComment = "question_comment"
    }
}
