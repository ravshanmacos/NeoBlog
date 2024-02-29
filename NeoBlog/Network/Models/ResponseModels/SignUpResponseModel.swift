//
//  SignUpResponseModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 29/02/24.
//

import Foundation

struct SignUpResponseModel: Decodable {
    let message: Message
}

struct Message: Decodable {
    let id: Int
    let email: String
    let username: String
}
