//
//  SignInViewControllerState.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 13/03/24.
//

import Foundation

struct SignInViewControllerState: Equatable {
    var viewState = SignInViewState()
    var errorsToPresent: Set<ErrorMessage> = []
}

struct SignInViewState: Equatable {
    
    //MARK: Properties
    var emailInputEnabled = true
    var passwordInputEnabled = true
    var signInButtonEnabled = true
    var signInActivityIndicatorAnimating = false
    
    //MARK: Methods
}
