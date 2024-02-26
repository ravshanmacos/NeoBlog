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
    
    case openSortByDateSheet
    case openMakeNewPeriod
    case openPostColllectionSheet
    
    case dismissSheet
    case popCurrent
    case popToMainScreen
    
    func hidesNavigationBar() -> Bool {
        switch self {
        case .mainScreen:
            return true
        default:
            return false
        }
    }
}
