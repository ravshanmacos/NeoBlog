//
//  SignUpRequestModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 29/02/24.
//

import Foundation

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
