//
//  OnboardViewState.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

enum OnboardingView {
    case welcome
    case signin
    case signup
    case sendMSGToEmail
    case confirmMSG
    case createNewPassword
    case popCurrent
    case popToRoot
    
    func hidesNavigationBar() -> Bool {
        switch self {
        case .welcome, .createNewPassword:
            return true
        default:
            return false
        }
    }
}
