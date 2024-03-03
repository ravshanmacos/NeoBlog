//
//  MainViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class MainViewModel: SignedInResponder, NotSignedInResponder {
    
    //MARK: Properties
    @Published private(set) var view: MainViewState = .launching
    
    private let userSessionRepository: UserSessionRepository
    
    //MARK: Methods
    
    init(userSessionRepository: UserSessionRepository) {
        self.userSessionRepository = userSessionRepository
    }
    
    func notSignedIn() {
        view = .onboarding
    }
    
    func signedIn(userSession: UserSession) {
        view = .signedIn(userSession: userSession)
    }
    
    func getUser(userSession: UserSession, _ completion: @escaping((UserProfile?) -> Void)) {
        userSessionRepository
            .userMe(userSession: userSession)
            .done({ userProfile in
                completion(userProfile)
            })
            .catch { error in
                print(error)
                completion(nil)
            }
    }
}
