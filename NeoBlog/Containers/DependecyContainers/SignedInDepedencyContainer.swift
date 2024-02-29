//
//  SignedInDepedencyContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class SignedInDepedencyContainer {
    
    //MARK: Properties
    private let sharedMainContainerViewModel: MainContainerViewModel
    private let sharedProfileContainerViewModel: ProfileContainerViewModel
    
    //From parent
    private let sharedMainViewModel: MainViewModel
    private let sharedUserSessionRepository: UserSessionRepository
    
    //context
    private let userSession: UserSession
    
    //MARK: Methods
    init(userSession: UserSession, appDependencyContainer: AppDependencyContainer) {
        
        func makeMainContainerViewModel() -> MainContainerViewModel {
            return MainContainerViewModel()
        }
        
        self.sharedUserSessionRepository = appDependencyContainer.sharedUserSessionRepository
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.userSession = userSession
        
        self.sharedMainContainerViewModel = makeMainContainerViewModel()
        self.sharedProfileContainerViewModel = ProfileContainerViewModel(userSession: userSession, userSessionRepository: sharedUserSessionRepository, notSignedInResponder: sharedMainViewModel)
    }
    
    // TabBar Controller
    func makeTabBarController() -> TabBarController {
        let mainContainerVC = makeMainContainerViewController()
        let addPostScreenVC = makeAddPostScreenViewController()
        let profileContainerVC = makeProfileContainerViewController()
        return TabBarController(mainContainerViewController: mainContainerVC,
                                addPostScreenViewController: addPostScreenVC,
                                profileContainerViewController: profileContainerVC)
    }
    
    //Main Screen Container
    func makeMainContainerViewController() -> MainContainerViewController {
        return MainContainerViewController(viewModel: sharedMainContainerViewModel, factory: self)
    }
    
    //Post Screen
    func makeAddPostScreenViewController() -> AddPostScreenViewController {
        return AddPostScreenViewController(viewModelFactory: self)
    }
    
    func makeAddPostViewModel() -> AddPostScreenViewModel {
        return AddPostScreenViewModel()
    }
    
    //Profile Screen Container
    func makeProfileContainerViewController() -> ProfileContainerViewController {
        return ProfileContainerViewController(viewModel: sharedProfileContainerViewModel, factory: self)
    }
}

//MARK: Post Details Screen
extension SignedInDepedencyContainer: MainContainerViewControllerFactory, PostDetailScreenViewModelFactory {
    // Main Screen View Controller
    func makeMainScreenViewController() -> MainScreenViewController {
        return MainScreenViewController(viewModelFactory: self)
    }
    
    func makeMainScreenViewModel() -> MainScreenViewModel {
        return MainScreenViewModel(goToPostDetailsNavigator: sharedMainContainerViewModel,
                                   goToSortByDateNavigator: sharedMainContainerViewModel,
                                   goToPostCollectionNavigator: sharedMainContainerViewModel)
    }
    
    //Sort By Date Sheet
    func makeSortByDateSheet() -> SortByDateSheet {
        let sortByDateSheet = SortByDateSheet(sortByDateSelectedResponder: sharedMainContainerViewModel, createNewPeriodResponder: sharedMainContainerViewModel)
        return sortByDateSheet
    }
    
    //Post Collection Sheet
    func makePostCollectionSheet() -> PostCollectionSheet {
        return PostCollectionSheet(viewModelFactory: self)
    }
    func makePostCollectionViewModel() -> PostCollectionSheetViewModel {
        return PostCollectionSheetViewModel()
    }
    
    //Sort By Period View Controller
    func makeSortByPeriodViewController() -> SortByPeriodViewController {
        return SortByPeriodViewController(viewControllerFactory: self, viewModelFactory: self)
    }
    
    func makeSortByPeriodViewModel() -> SortByPeriodViewModel {
        return SortByPeriodViewModel(newPeriodCreatedResponder: sharedMainContainerViewModel, dateDidSelectedResponder: sharedMainContainerViewModel)
    }
    
    //Choose Date
    func makeChooseDateViewController(periodType: PeriodType) -> ChooseDateViewController {
        return ChooseDateViewController(periodType: periodType)
    }
    
    //Post Details
    func makePostDetailsViewController() -> PostDetailScreenViewController {
        return PostDetailScreenViewController(viewModelFactory: self)
    }
    
    func makePostDetailScreenViewModel() -> PostDetailScreenViewModel {
        return PostDetailScreenViewModel()
    }
}

extension SignedInDepedencyContainer: MainScreenViewModelFactory, AddPostViewModelFactory, ProfileViewModelFactory, SortByPeriodViewModelFactory, SortByPeriodViewControllerFactory, PostCollectionViewModelFactory {}

//MARK: Add Post Screen
extension SignedInDepedencyContainer: ProfileContainerViewControllerFactory, EditProfileViewModelFactory, ChangeLoginAndEmailViewModelFactory, ChangePasswordViewModelFactory {
    // Pofile View Controller
    func makeProfileScreenViewController() -> ProfileScreenViewController {
        return ProfileScreenViewController(viewModelFactory: self)
    }
    
    func makeProfileViewModel() -> ProfileScreenViewModel {
        return ProfileScreenViewModel(goToEditProfileSheetNavigator: sharedProfileContainerViewModel)
    }
    
    //Two Action Sheet
    
    func makeEditProfileSheet() -> EditProfileSheet {
        return EditProfileSheet(goToEditProfileVC: sharedProfileContainerViewModel, logoutResponder: sharedProfileContainerViewModel, dissmissViewResponder: sharedProfileContainerViewModel)
    }
    
    // Edit Profile View Controller
    
    func makeEditProfileVC() -> EditProfileViewController {
        return EditProfileViewController(factory: self)
    }
    
    func makeEditProfileViewModel() -> EditProfileViewModel {
        return EditProfileViewModel(goToChangeLoginAndEmailNavigator: sharedProfileContainerViewModel, goToChangePasswordNavigator: sharedProfileContainerViewModel)
    }
    
    //Change Login and Email
    func makeChangeLoginAndEmail() -> ChangeLoginAndEmailViewController {
        return ChangeLoginAndEmailViewController(viewModelFactory: self)
    }
    
    func makeChangeLoginAndEmailViewModel() -> ChangeLoginAndEmailViewModel {
        return ChangeLoginAndEmailViewModel(signedInResponder: sharedMainViewModel)
    }
    
    //Change Password
    func makeChangePassword() -> ChangePasswordViewController {
        return ChangePasswordViewController(viewModelFactory: self)
    }
    
    func makeChangePasswordViewModel() -> ChangePasswordViewModel {
        return ChangePasswordViewModel(signedInResponder: sharedMainViewModel)
    }
}
