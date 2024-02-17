//
//  OnboardingViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation
import Combine

typealias OnboardingNavigationAction = NavigationAction<OnboardingView>

class OnboardingViewModel {
    
    // MARK: - Properties
    
    @Published private(set) var navigationAction: OnboardingNavigationAction = .present(view: .welcome)
    
    // MARK: - Methods
    
    func navigateToSignUp() {
        navigationAction = .present(view: .signup)
    }
    
    func navigateToSignIn() {
        navigationAction = .present(view: .signin)
    }
    
    func navigateSendMsgToEmail() {
        navigationAction = .present(view: .sendMSGToEmail)
    }
    
    func navigateConfirmMsgNavigator() {
        navigationAction = .present(view: .confirmMSG)
    }
    
    func navigateCreateNewPassword() {
        navigationAction = .present(view: .createNewPassword)
    }
    
    func uiPresented(onboardingView: OnboardingView) {
        navigationAction = .presented(view: onboardingView)
    }
}

extension OnboardingViewModel:  GoToSignUpNavigator, GoToSignInNavigator, GoToSendMSGToEmailNavigator, GoToConfirmMSGNavigator, GoToCreateNewPasswordNavigator {}
