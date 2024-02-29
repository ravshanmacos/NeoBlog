//
//  OnboardingDependencyContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class OnboardingDependencyContainer {
    
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
        let welcomeVC = makeWelcomeViewController()
        let signIn = makeSignInViewController()
        let signUp = makeSignUpViewController()
        let sendMsgToEmail = makeSendMsgtoEmailViewController()
        let confirmMsg = makeConfirmMsgViewController()
        let createNewPassword = makeCreateNewPasswordViewController()
        
        return OnboardingViewController(viewModel: sharedOnboardingViewModel,
                                        welcomeViewController: welcomeVC,
                                        signInViewController: signIn,
                                        signUpViewController: signUp,
                                        sendMsgToEmailViewController: sendMsgToEmail,
                                        confirmMsgViewController: confirmMsg,
                                        createNewPasswordViewController: createNewPassword)
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
        return SignUpViewModel()
    }
    
    //Send Message To Email View Controller
    func makeSendMsgtoEmailViewController() -> SendMSGToEmailViewController {
        return SendMSGToEmailViewController(viewModelFactory: self)
    }
    
    func makeSendMsgToEmailViewModel() -> SendMSGToEmailViewModel {
        return SendMSGToEmailViewModel(goToConfirmMsgNavigator: sharedOnboardingViewModel)
    }
    
    //Confirm Message View Controller
    func makeConfirmMsgViewController() -> ConfirmMSGViewController {
        return ConfirmMSGViewController(viewModelFactory: self)
    }
    
    func makeConfirmMsgViewModel() -> ConfirmMSGViewModel {
        return ConfirmMSGViewModel(goToCreateNewPasswordNavigator: sharedOnboardingViewModel)
    }
    
    //Create New Password View Controller
    func makeCreateNewPasswordViewController() -> CreateNewPasswordViewController {
        return CreateNewPasswordViewController(viewModelFactory: self)
    }
    
    func makeCreateNewPasswordViewModel() -> CreateNewPasswordViewModel {
        return CreateNewPasswordViewModel(signedInResponder: shareMainViewModel)
    }
}

extension OnboardingDependencyContainer: WelcomeViewModelFactory, SignInViewModelFactory, SignUpViewModelFactory, SendMSGToEmailViewModelFactory, ConfirmMSGViewModelFactory, CreateNewPasswordViewModelFactory{}
