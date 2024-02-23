//
//  MainScreenContainerViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import Foundation

typealias MainContainerNavigationAction = NavigationAction<MainContainerViewState>

class MainContainerViewModel {
    //MARK: Properties
    @Published private(set) var navigationAction: MainContainerNavigationAction = .present(view: .mainScreen)
    
    //MARK: Methods
    
    func navigateToPostDetails() {
        navigationAction = .present(view: .postDetails)
    }
    
    func uiPresented(mainContainerViewState: MainContainerViewState) {
        navigationAction = .presented(view: mainContainerViewState)
    }
}

extension MainContainerViewModel: GoToPostDetailsNavigator {}
