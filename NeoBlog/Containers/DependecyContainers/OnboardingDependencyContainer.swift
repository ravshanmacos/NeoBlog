//
//  OnboardingDependencyContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class OnboardingDependencyContainer: OnboardingViewControllerFactory{
    
    //MARK: Properties
    private let sharedUserSessionRepository: UserSessionRepository
    private let shareMainViewModel: MainViewModel
    private let sharedOnboardingViewModel: OnboardingViewModel
    
    //MARK: Methods
    
    init(appDependencyContainer: AppDependencyContainer) {
        
        func makeOnboardingViewModel() -> OnboardingViewModel {
            return OnboardingViewModel()
        }
        
        self.sharedUserSessionRepository = appDependencyContainer.sharedUserSessionRepository
        self.shareMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedOnboardingViewModel = makeOnboardingViewModel()
    }
    
    //Onboarding View Controller
    func makeOnboardingViewController() -> OnboardingViewController {
        return OnboardingViewController(viewModel: sharedOnboardingViewModel, viewControllersFactory: self)
    }
    
    //Welcome View Controller
    func makeWelcomeViewController() -> WelcomeViewController {
        return WelcomeViewController(viewModelFactory: self)
    }
    
    func makeWelcomeViewModel() -> WelcomeViewModel {
        return WelcomeViewModel(goToSignInNavigator: sharedOnboardingViewModel, goToSignUpNavigator: sharedOnboardingViewModel)
    }
    //Sign In View Controller
    func makeSignInViewController() -> SignInViewController {
        return SignInViewController(viewModelFactory: self)
    }
    
    func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel(userSessionRepository: sharedUserSessionRepository, signedInResponder: shareMainViewModel, goToSendMsgToEmailNavigator: sharedOnboardingViewModel)
    }
    //Sign Up View Controller
    func makeSignUpViewController() -> SignUpViewController {
        return SignUpViewController(viewModelFactory: self)
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel(userSessionRepository: sharedUserSessionRepository, popCurrentResponder: sharedOnboardingViewModel, goToSignInNavigator: sharedOnboardingViewModel)
    }
    
    //Send Message To Email View Controller
    func makeSendMsgtoEmailViewController() -> SendMSGToEmailViewController {
        return SendMSGToEmailViewController(viewModelFactory: self)
    }
    
    func makeSendMsgToEmailViewModel() -> SendMSGToEmailViewModel {
        return SendMSGToEmailViewModel(userSessionRepository: sharedUserSessionRepository, goToConfirmMsgNavigator: sharedOnboardingViewModel)
    }
    
    //Confirm Message View Controller
    func makeConfirmMsgViewController(email: String) -> ConfirmMSGViewController {
        return ConfirmMSGViewController(email: email, viewModelFactory: self)
    }
    
    func makeConfirmMsgViewModel() -> ConfirmMSGViewModel {
        return ConfirmMSGViewModel(userSessionRepository: sharedUserSessionRepository, goToCreateNewPasswordNavigator: sharedOnboardingViewModel)
    }
    
    //Create New Password View Controller
    func makeCreateNewPasswordViewController(userSession: UserSession) -> CreateNewPasswordViewController {
        return CreateNewPasswordViewController(userSession: userSession, viewModelFactory: self)
    }
    
    func makeCreateNewPasswordViewModel() -> CreateNewPasswordViewModel {
        return CreateNewPasswordViewModel(userSessionRepository: sharedUserSessionRepository, signedInResponder: shareMainViewModel)
    }
}

extension OnboardingDependencyContainer: WelcomeViewModelFactory, SignInViewModelFactory, SignUpViewModelFactory, SendMSGToEmailViewModelFactory, ConfirmMSGViewModelFactory, CreateNewPasswordViewModelFactory{}
