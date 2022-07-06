//
//  CommentModel.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import Foundation


// MARK: - Welcome
struct CommentModel: Codable {
    let status: Bool
    let message: String
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case comments = "data"
    }
}

struct PostCommentModel: Codable {
    let status: Bool
    let message: String
    let comment: Comment
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case comment = "data"
    }
}

// MARK: - Datum
struct Comment: Codable, Identifiable {
    
    
    let id = UUID().uuidString
    let commentID, questionID: String
    let userID: UserID?
    let comment, createdAt: String

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case questionID = "question_id"
        case userID = "user_id"
        case comment
        case createdAt = "created_at"
    }
}
