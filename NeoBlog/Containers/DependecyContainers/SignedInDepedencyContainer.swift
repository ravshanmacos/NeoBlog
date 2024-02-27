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
    private let sharedProfileContainerViewModel: ProfileContainerViewModel
    //private let sharedUserSession: UserSession
    
    //MARK: Methods
    init(appDependencyContainer: AppDependencyContainer) {
        
        func makeMainContainerViewModel() -> MainContainerViewModel {
            return MainContainerViewModel()
        }
        
        func makeProfileContainerViewModel() -> ProfileContainerViewModel {
            return ProfileContainerViewModel()
        }
        
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedMainContainerViewModel = makeMainContainerViewModel()
        self.sharedProfileContainerViewModel = makeProfileContainerViewModel()
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
extension SignedInDepedencyContainer: ProfileContainerViewControllerFactory {
    // Pofile View Controller
    func makeProfileScreenViewController() -> ProfileScreenViewController {
        return ProfileScreenViewController(viewModelFactory: self)
    }
    
    func makeProfileViewModel() -> ProfileScreenViewModel {
        return ProfileScreenViewModel()
    }
}
