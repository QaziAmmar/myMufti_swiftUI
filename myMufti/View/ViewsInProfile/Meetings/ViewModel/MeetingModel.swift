//
//  MeetingModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import Foundation
// MARK: - Welcome
struct MeetingModel: Codable {
    let status: Bool
    let message: String
    let meetings: [Meeting]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case meetings = "data"
    }
    
}

// MARK: - Datum
struct Meeting: Codable, Identifiable {
    let id = UUID()
    let quesID, userID, muftiID, questions: String
    let category, date, createdAt, modified: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case quesID = "ques_id"
        case userID = "user_id"
        case muftiID = "mufti_id"
        case questions, category, date
        case createdAt = "created_at"
        case modified, status
    }
}
