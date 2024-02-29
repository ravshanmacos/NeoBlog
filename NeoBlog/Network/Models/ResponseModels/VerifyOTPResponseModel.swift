//
//  VerifyOTPResponseModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 29/02/24.
//

import Foundation

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
