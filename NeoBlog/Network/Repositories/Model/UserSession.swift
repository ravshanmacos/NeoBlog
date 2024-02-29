//
//  UserSession.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

struct UserSession: Codable {
    //MARK: Properties
    let remoteSession: RemoteUserSession
    
    //MARK: Methods
    init(remoteSession: RemoteUserSession) {
        self.remoteSession = remoteSession
    }
}

extension UserSession: Equatable {
    static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
        return lhs.remoteSession == rhs.remoteSession
    }
}
