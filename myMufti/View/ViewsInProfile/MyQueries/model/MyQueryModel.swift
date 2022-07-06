//
//  MyQueryModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 21/06/2022.
//

import Foundation

// MARK: - Welcome
struct MyQueryModel: Codable {
    let status: Bool
    let message: String
    let data: [MyQuery]
}

// MARK: - Datum
struct MyQuery: Codable, Identifiable, Equatable {
    static func == (lhs: MyQuery, rhs: MyQuery) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String?
    let userID: UserID?
    let date: String?
    let muftiID, questions, category: String
    let createdAt, modified, status: String
    var timeago: String {
        return DateManager.standard.timeAgoDisplay(from: createdAt)
    }

    enum CodingKeys: String, CodingKey {
        case id = "ques_id"
        case userID = "user_id"
        case muftiID = "mufti_id"
        case questions, category, date
        case createdAt = "created_at"
        case modified, status
    }
}

// MARK: - UserID
struct UserID: Codable {
    let image: String?
    let id, name: String?
}
