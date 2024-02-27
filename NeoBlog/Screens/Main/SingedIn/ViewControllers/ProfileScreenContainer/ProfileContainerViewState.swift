//
//  ProfileContainerViewState.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import Foundation

enum ProfileContainerViewState {
    case mainScreen
    
    func hidesNavigationBar() -> Bool {
        switch self {
        case .mainScreen:
            return true
        }
    }
}
