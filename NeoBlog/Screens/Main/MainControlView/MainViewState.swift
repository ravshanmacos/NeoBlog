//
//  MainViewState.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

enum MainViewState {
    case launching
    case onboarding
    case signedIn(userSession: UserSession)
}

extension MainViewState: Equatable {
    static func ==(lhs: MainViewState, rhs: MainViewState) -> Bool {
      switch (lhs, rhs) {
      case (.launching, .launching):
        return true
      case (.onboarding, .onboarding):
        return true
      case let (.signedIn(l), .signedIn(r)):
        return l == r
      case (.launching, _),
           (.onboarding, _),
           (.signedIn, _):
        return false
      }
    }
}
