//
//  HistoryModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import Foundation
// MARK: - Welcome
struct HistoryModel: Codable {
    let status: Bool
    let message: String
    let histories: [History]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case histories = "data"
    }
}

// MARK: - Datum
struct History: Codable, Identifiable {
    let id = UUID()
    let questionID, userID, questionTitle, question: String
    let options, timeLimit, createdAt: String
    let totalVote, votePerctageFor1StAns, votePerctageFor2NdAns: Int

    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case userID = "user_id"
        case questionTitle = "question_title"
        case question, options
        case timeLimit = "time_limit"
        case createdAt = "created_at"
        case totalVote = "total_vote"
        case votePerctageFor1StAns = "vote_perctage_for_1st_ans"
        case votePerctageFor2NdAns = "vote_perctage_for_2nd_ans"
    }
}
