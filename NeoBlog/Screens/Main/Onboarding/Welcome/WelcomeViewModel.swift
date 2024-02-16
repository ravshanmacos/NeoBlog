//
//  WelcomeViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class WelcomeViewModel {
    //MARK: Properties
    private let goToSignInNavigator: GoToSignInNavigator
    private let goToSignUpNavigator: GoToSignUpNavigator
    
    //MARK: Methods
    init(goToSignInNavigator: GoToSignInNavigator, goToSignUpNavigator: GoToSignUpNavigator) {
        self.goToSignInNavigator = goToSignInNavigator
        self.goToSignUpNavigator = goToSignUpNavigator
    }
    
    func signIn() {
        goToSignInNavigator.navigateToSignIn()
    }
    
    func signUp() {
        goToSignUpNavigator.navigateToSignUp()
    }
}
