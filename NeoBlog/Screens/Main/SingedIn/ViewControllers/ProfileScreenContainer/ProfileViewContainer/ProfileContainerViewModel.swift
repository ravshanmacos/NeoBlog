//
//  MainScreenContainerViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import Foundation

typealias ProfileContainerNavigationAction = NavigationAction<ProfileContainerViewState>

class ProfileContainerViewModel: LogoutResponder, DissmissViewResponder {
    
    //MARK: Properties
    
    private let userSession: UserSession
    private let userSessionRepository: UserSessionRepository
    private let notSignedInResponder: NotSignedInResponder
    
    @Published private(set) var navigationAction: ProfileContainerNavigationAction = .present(view: .mainScreen)
    
    //MARK: Methods
    init(userSession: UserSession, userSessionRepository: UserSessionRepository, notSignedInResponder: NotSignedInResponder) {
        self.userSession = userSession
        self.userSessionRepository = userSessionRepository
        self.notSignedInResponder = notSignedInResponder
    }
    
    func logout() {
        userSessionRepository.signOut(userSession: userSession)
            .done({ _ in
                self.notSignedInResponder.notSignedIn()
            })
            .catch { error in
                print(error)
            }
        navigationAction = .present(view: .logout)
    }
    
    func dissmissCurrentView() {
        navigationAction = .present(view: .dissmissCurrentView)
    }
    
    
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

