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
    
    var postID: Int?
    
    //MARK: Methods
    
    //View Controller navigation
    func navigateToPostDetails(postID: Int) {
        self.postID = postID
        navigationAction = .present(view: .postDetails)
    }
    
    //Closing navigation
    func dissmissSheet() {
        navigationAction = .present(view: .dismissSheet)
    }

    func popCurrent() {
        navigationAction = .present(view: .popCurrent)
    }
    
    func popToMainScreen() {
        navigationAction = .present(view: .popToMainScreen)
    }
    
    func uiPresented(mainContainerViewState: MainContainerViewState) {
        navigationAction = .presented(view: mainContainerViewState)
    }
}

extension MainContainerViewModel: SortByDateSelectedResponder, DateDidSelectedResponder {
    
    func sortByDateDidSelected(with tag: Int) {
        navigationAction = .present(view: .dismissSheet)
    }
    
    func datePeriodSelected(startDate: Date, endDate: Date) {
        print("start date: \(startDate)")
        print("end date: \(endDate)")
        popToMainScreen()
    }
}

extension MainContainerViewModel: GoToPostDetailsNavigator {}
