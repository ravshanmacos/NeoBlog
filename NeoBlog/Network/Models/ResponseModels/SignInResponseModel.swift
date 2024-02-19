//
//  SignInResponseModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation

struct SignInResponseModel: Decodable {
    let refresh: String
    let access: String
}
