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
    private let sharedMainContainerViewModel: MainContainerViewModel
    //private let sharedUserSession: UserSession
    
    //MARK: Methods
    init(appDependencyContainer: AppDependencyContainer) {
        
        func makeMainContainerViewModel() -> MainContainerViewModel {
            return MainContainerViewModel()
        }
        
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedMainContainerViewModel = makeMainContainerViewModel()
    }
    
    // TabBar Controller
    func makeTabBarController() -> TabBarController {
        let mainContainerVC = makeMainContainerViewController()
        let addPostScreenVC = makeAddPostScreenViewController()
        let profileScreenVC = makeProfileScreenViewController()
        return TabBarController(mainContainerViewController: mainContainerVC,
                                addPostScreenViewController: addPostScreenVC,
                                profileScreenViewController: profileScreenVC)
    }
    
    //MainContainerViewController
    func makeMainContainerViewController() -> MainContainerViewController {
        return MainContainerViewController(viewModel: sharedMainContainerViewModel, factory: self)
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

//MARK: Post Details Screen
extension SignedInDepedencyContainer: MainContainerViewControllerFactory, PostDetailScreenViewModelFactory {
    
    // Main Screen View Controller
    func makeMainScreenViewController() -> MainScreenViewController {
        return MainScreenViewController(viewModelFactory: self)
    }
    
    func makeMainScreenViewModel() -> MainScreenViewModel {
        return MainScreenViewModel(goToPostDetailsNavigator: sharedMainContainerViewModel)
    }
    
    func makePostDetailsViewController() -> PostDetailScreenViewController {
        return PostDetailScreenViewController(viewModelFactory: self)
    }
    
    func makePostDetailScreenViewModel() -> PostDetailScreenViewModel {
        return PostDetailScreenViewModel()
    }
}

extension SignedInDepedencyContainer: MainScreenViewModelFactory, AddPostViewModelFactory, ProfileViewModelFactory {}
