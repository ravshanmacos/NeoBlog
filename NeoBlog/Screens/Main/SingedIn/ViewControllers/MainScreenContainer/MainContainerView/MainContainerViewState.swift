//
//  MainContainerViewState.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import Foundation

enum MainContainerViewState {
    
    case mainScreen
    case postDetails
    case addPostScreen
    case dismissSheet
    case popCurrent
    case popToMainScreen
    
    func hidesNavigationBar() -> Bool {
        switch self {
        case .mainScreen, .addPostScreen:
            return true
        default:
            return false
        }
    }
}
