//
//  AppDependencyContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation
class AppDependencyContainer {
    
    //MARK: Properties
    let sharedMainViewModel: MainViewModel
    
    init() {
        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }
        
        self.sharedMainViewModel = makeMainViewModel()
    }
    
    //MARK: Methods
    
    //Main View Controller
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: sharedMainViewModel, viewControllersFactory: self)
    }
    
    //Launch View Controller
    func makeLaunchViewController() -> LaunchViewController {
        return LaunchViewController(viewModelFactory: self)
    }
    
    func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel(notSignedInResponder: sharedMainViewModel, signedInResponder: sharedMainViewModel)
    }

    //Onboarding View Controller
    func makeOnboardingViewController() -> OnboardingViewController {
        let dc = makeOnboardingDependencyContainer()
        return dc.makeOnboardingViewController()
    }
    
    func makeOnboardingDependencyContainer() -> OnboardingDependencyContainer {
        return OnboardingDependencyContainer(appDependencyContainer: self)
    }
    
    //SignedIn View Controller
    func makeSignedInViewController() -> SignedInViewController {
        return SignedInViewController()
    }
}

extension AppDependencyContainer: MainViewControllerFactory, LaunchViewModelFactory {}
