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
    var userProfile: UserProfile
    
    @Published private(set) var navigationAction: ProfileContainerNavigationAction = .present(view: .mainScreen)
    
    var collection: Collection?
    
    //MARK: Methods
    init(userSession: UserSession, userProfile: UserProfile, userSessionRepository: UserSessionRepository,
         notSignedInResponder: NotSignedInResponder) {
        self.userSession = userSession
        self.userProfile = userProfile
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
extension ProfileContainerViewModel: GoToEditProfileSheetNavigator, GoToEditProfileVC, GoToChangeLoginAndEmailNavigator, GoToChangePasswordNavigator, GoToMainScreenNavigator, GoToCollectionPosts {
    func navigateToCollectionPosts(collection: Collection) {
        self.collection = collection
        navigationAction = .present(view: .collectionPosts)
    }
    
    func navigateToMainScreen(newUsername: String?, newEmail: String?) {
        if let newUsername {
            userProfile.username = newUsername
        }
        if let newEmail {
            userProfile.email = newEmail
        }
        navigationAction = .present(view: .mainScreen)
    }
    
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

