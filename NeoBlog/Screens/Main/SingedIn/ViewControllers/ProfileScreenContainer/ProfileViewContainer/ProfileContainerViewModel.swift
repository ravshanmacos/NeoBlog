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

extension ProfileContainerViewModel {
    
}

extension ProfileContainerViewModel {}
