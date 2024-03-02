//
//  OnboardingViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation
import Combine

typealias OnboardingNavigationAction = NavigationAction<OnboardingView>

class OnboardingViewModel: PopCurrentResponder, PopToRootResponder {
    
    // MARK: - Properties
    
    @Published private(set) var navigationAction: OnboardingNavigationAction = .present(view: .welcome)
    var userSession: UserSession?
    var email: String?
    
    // MARK: - Methods
    func popToCurrentView() {
        navigationAction = .present(view: .popCurrent)
    }
    
    func popToRootView() {
        navigationAction = .present(view: .popToRoot)
    }
   
}

extension OnboardingViewModel:  GoToSignUpNavigator, GoToSignInNavigator, GoToSendMSGToEmailNavigator, GoToConfirmMSGNavigator, GoToCreateNewPasswordNavigator {
    
    func navigateCreateNewPassword(userSession: UserSession) {
        self.userSession = userSession
        navigationAction = .present(view: .createNewPassword)
    }
    
    func navigateToSignUp() {
        navigationAction = .present(view: .signup)
    }
    
    func navigateToSignIn() {
        navigationAction = .present(view: .signin)
    }
    
    func navigateSendMsgToEmail() {
        navigationAction = .present(view: .sendMSGToEmail)
    }
    
    func navigateConfirmMsgNavigator(email: String) {
        self.email = email
        navigationAction = .present(view: .confirmMSG)
    }
    
    func uiPresented(onboardingView: OnboardingView) {
        navigationAction = .presented(view: onboardingView)
    }
}
