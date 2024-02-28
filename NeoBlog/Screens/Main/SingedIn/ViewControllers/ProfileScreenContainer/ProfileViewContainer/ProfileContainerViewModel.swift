//
//  MainScreenContainerViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import Foundation

typealias ProfileContainerNavigationAction = NavigationAction<ProfileContainerViewState>

class ProfileContainerViewModel {
    //MARK: Properties
    
    @Published private(set) var navigationAction: ProfileContainerNavigationAction = .present(view: .mainScreen)
    
    //MARK: Methods
    func uiPresented(ProfileContainerViewState: ProfileContainerViewState) {
        navigationAction = .presented(view: ProfileContainerViewState)
    }
    
}

//MARK: Navigations
extension ProfileContainerViewModel: GoToEditProfileSheetNavigator, GoToEditProfileVC, GoToChangeLoginAndEmailNavigator, GoToChangePasswordNavigator {
    func navigateToEditProfileSheet() {
        navigationAction = .present(view: .editProfile)
    }
    
    func navigateToEditProfileVC() {
        navigationAction = .present(view: .editProfileVC)
    }
    
    func navigateToChangeLoginAndEmail() {
        navigationAction = .present(view: .changeLoginAndEmail)
    }
    
    func navigateToChangePassowrd() {
        navigationAction = .present(view: .changePassword)
    }
}

//MARK: Reponders
extension ProfileContainerViewModel: LogoutResponder, DissmissViewResponder {
    func logout() {
        navigationAction = .present(view: .logout)
    }
    
    func dissmissCurrentView() {
        navigationAction = .present(view: .dissmissCurrentView)
    }
}
