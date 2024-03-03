//
//  AppDependencyContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation
class AppDependencyContainer {
    
    //MARK: Properties
    let sharedUserSessionRepository: UserSessionRepository
    let sharedMainViewModel: MainViewModel
    
    init() {
        func makeUserSessionRepository() -> UserSessionRepository {
            let dataStore = makeUserSessionDataStore()
            let authRemoteAPI = makeAuthRemoteAPI()
            return NeoBlogUserSessionRepository(dataStore: dataStore, remoteAPI: authRemoteAPI)
        }
        
        func makeUserSessionDataStore() -> UserSessionDataStore {
            let coder = makeUserSessionCoder()
            return KeychainUserSessionDataStore(userSessionCoder: coder)
        }
        
        func makeUserSessionCoder() -> UserSessionCoding {
            return UserSessionPropertyListCoder()
        }
        
        func makeAuthRemoteAPI() -> AuthRemoteAPI {
            return NeoBlogAuthRemoteAPI()
        }
        
        self.sharedUserSessionRepository = makeUserSessionRepository()
        self.sharedMainViewModel = MainViewModel(userSessionRepository: sharedUserSessionRepository)
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
        return LaunchViewModel(userSessionRepository: sharedUserSessionRepository, notSignedInResponder: sharedMainViewModel, signedInResponder: sharedMainViewModel)
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
    func makeSignedInViewController(userSession: UserSession, userProfile: UserProfile) -> TabBarController {
        let dc = makeSignedInDependencyContainer(userSession: userSession, userProfile: userProfile)
        return dc.makeTabBarController()
    }
    
    func makeSignedInDependencyContainer(userSession: UserSession, userProfile: UserProfile) -> SignedInDepedencyContainer {
        return SignedInDepedencyContainer(userSession: userSession, userProfile: userProfile, appDependencyContainer: self)
    }
}

extension AppDependencyContainer: MainViewControllerFactory, LaunchViewModelFactory {}
