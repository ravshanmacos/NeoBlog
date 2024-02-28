//
//  ProfileContainerViewState.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import Foundation

enum ProfileContainerViewState {
    case mainScreen
    case editProfile
    case editProfileVC
    case changeLoginAndEmail
    case changePassword
    case logout
    case dissmissCurrentView
    
    func hidesNavigationBar() -> Bool {
        switch self {
        case .mainScreen:
            return true
            
        default:
            return false
        }
    }
}
