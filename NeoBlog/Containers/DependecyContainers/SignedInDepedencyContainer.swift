//
//  SignedInDepedencyContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class SignedInDepedencyContainer {
    
    //MARK: Properties
    private let sharedMainViewModel: MainViewModel
    
    //private let sharedUserSession: UserSession
    
    //MARK: Methods
    init(appDependencyContainer: AppDependencyContainer) {
        
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
    }
    
    // TabBar Controller
    func makeTabBarController() -> TabBarController {
        let mainScreenVC = makeMainScreenViewController()
        let addPostScreenVC = makeAddPostScreenViewController()
        let profileScreenVC = makeProfileScreenViewController()
        
        return TabBarController(mainScreenViewController: mainScreenVC,
                                addPostScreenViewController: addPostScreenVC,
                                profileScreenViewController: profileScreenVC)
    }
    
    // Main Screen View Controller
    func makeMainScreenViewController() -> MainScreenViewController {
        return MainScreenViewController(viewModelFactory: self)
    }
    
    func makeMainScreenViewModel() -> MainScreenViewModel {
        return MainScreenViewModel()
    }
    // Add Post View Controller
    func makeAddPostScreenViewController() -> AddPostScreenViewController {
        return AddPostScreenViewController(viewModelFactory: self)
    }
    
    func makeAddPostViewModel() -> AddPostScreenViewModel {
        return AddPostScreenViewModel()
    }
    
    // Pofile View Controller
    func makeProfileScreenViewController() -> ProfileScreenViewController {
        return ProfileScreenViewController(viewModelFactory: self)
    }
    
    func makeProfileViewModel() -> ProfileScreenViewModel {
        return ProfileScreenViewModel()
    }
}

extension SignedInDepedencyContainer: MainScreenViewModelFactory, AddPostViewModelFactory, ProfileViewModelFactory {}
