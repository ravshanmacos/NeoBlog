//
//  AuthRequestModels.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation

struct SignInRequestModel: Encodable {
    let email: String
    let password: String
}

struct SendOTPRequestModel: Encodable {
    let email: String
}

struct VerifyOTPRequestModel: Encodable {
    let code: String
}

struct SignUpRequestModel: Encodable {
    let email: String
    let username: String
    let password: String
    let confirmPassword: String
    
    enum CodingKeys: String, CodingKey {
        case email, username, password
        case confirmPassword = "confirm_password"
    }
}

struct ChangeForgotPasswordRequestModel: Encodable {
    let password: String
    let confirmPassword: String
    
    enum CodingKeys: String, CodingKey {
        case password
        case confirmPassword = "confirm_password"
    }
}
