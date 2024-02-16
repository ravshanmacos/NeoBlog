//
//  OnboardViewState.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

public enum OnboardingView {
  
  case welcome
  case signin
  case signup

  public func hidesNavigationBar() -> Bool {
    switch self {
    case .welcome:
      return true
    default:
      return false
    }
  }
}
