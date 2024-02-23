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
    
    func hidesNavigationBar() -> Bool {
        switch self {
        case .mainScreen:
            return true
        default:
            return false
        }
    }
}
