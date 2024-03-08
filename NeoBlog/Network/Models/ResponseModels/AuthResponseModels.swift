//
//  AuthResponseModels.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation

struct UserProfile: Decodable {
    let id: Int?
    var username: String?
    var email: String?
}

struct SignInResponseModel: Decodable {
    let refresh: String
    let access: String
}

struct SignUpResponseModel: Decodable {
    let message: Message
}

struct Message: Decodable {
    let id: Int
    let email: String
    let username: String
}

struct GeneralResponse: Decodable {
    let message: String
}

struct EmptyResponse: Decodable {}

struct VerifyOTPResponseModel: Decodable {
    let message: String
    let userID: String
    let refresh: String
    let access: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case userID = "user_id"
        case refresh
        case access
    }
}
