//
//  SignInRequestModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation

struct SignInRequestModel: Encodable {
    let email: String
    let password: String
}
