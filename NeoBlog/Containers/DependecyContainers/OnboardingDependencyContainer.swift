//
//  OnboardingDependencyContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class OnboardingDependencyContainer {
    
    //MARK: Properties
    private let shareMainViewModel: MainViewModel
    private let sharedOnboardingViewModel: OnboardingViewModel
    
    //MARK: Methods
    
    init(appDependencyContainer: AppDependencyContainer) {
        
        func makeOnboardingViewModel() -> OnboardingViewModel {
            return OnboardingViewModel()
        }
        
        self.shareMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedOnboardingViewModel = makeOnboardingViewModel()
    }
    
    //Onboarding View Controller
    
    func makeOnboardingViewController() -> OnboardingViewController {
        let welcomeVC = makeWelcomeViewController()
        let signIn = makeSignInViewController()
        let signUp = makeSignUpViewController()
        
        return OnboardingViewController(viewModel: sharedOnboardingViewModel,
                                        welcomeViewController: welcomeVC,
                                        signInViewController: signIn,
                                        signUpViewController: signUp)
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
        return SignInViewModel()
    }
    //Sign Up View Controller
    func makeSignUpViewController() -> SignUpViewController {
        return SignUpViewController(viewModelFactory: self)
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel()
    }
}

extension OnboardingDependencyContainer: WelcomeViewModelFactory, SignInViewModelFactory, SignUpViewModelFactory{}
