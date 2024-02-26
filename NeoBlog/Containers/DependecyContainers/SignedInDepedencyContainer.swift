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
    private let sharedAddPostContainerViewModel: AddPostContainerViewModel
    //private let sharedUserSession: UserSession
    
    //MARK: Methods
    init(appDependencyContainer: AppDependencyContainer) {
        
        func makeMainContainerViewModel() -> MainContainerViewModel {
            return MainContainerViewModel()
        }
        
        func makeAddPostContainerViewModel() -> AddPostContainerViewModel {
            return AddPostContainerViewModel()
        }
        
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedMainContainerViewModel = makeMainContainerViewModel()
        self.sharedAddPostContainerViewModel = makeAddPostContainerViewModel()
    }
    
    // TabBar Controller
    func makeTabBarController() -> TabBarController {
        let mainContainerVC = makeMainContainerViewController()
        let addPostContainerVC = makeAddPostContainerViewController()
        let profileScreenVC = makeProfileScreenViewController()
        return TabBarController(mainContainerViewController: mainContainerVC,
                                addPostContainerViewController: addPostContainerVC,
                                profileScreenViewController: profileScreenVC)
    }
    
    //MainContainerViewController
    func makeMainContainerViewController() -> MainContainerViewController {
        return MainContainerViewController(viewModel: sharedMainContainerViewModel, factory: self)
    }
    
    // Add Post View Controller
    func makeAddPostContainerViewController() -> AddPostContainerViewController {
        return AddPostContainerViewController(viewModel: sharedAddPostContainerViewModel, viewControllerFactory: self)
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
extension SignedInDepedencyContainer: AddPostContainerViewControllerFactory {
    // Add Post Screen
    func makeAddPostScreenViewController() -> AddPostScreenViewController {
        return AddPostScreenViewController(viewModelFactory: self)
    }
    
    func makeAddPostViewModel() -> AddPostScreenViewModel {
        return AddPostScreenViewModel(closeAddPostResponder: sharedAddPostContainerViewModel)
    }
}
