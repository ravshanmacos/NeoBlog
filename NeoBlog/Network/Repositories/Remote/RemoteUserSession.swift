//
//  RemoteUserSession.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

struct RemoteUserSession: Codable, Equatable {
    //MARK: Properties
    let accessToken: String
    let refreshToken: String
    
    //MARK: Methods
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
