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
    
    //View Controller navigation
    func navigateToPostDetails() {
        navigationAction = .present(view: .postDetails)
    }
    
    func navigateToCreateNewPeriod() {
        navigationAction = .present(view: .openMakeNewPeriod)
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

extension MainContainerViewModel: SortByDateSelectedResponder, NewPeriodCreatedResponder, DateDidSelectedResponder {
    
    func sortByDateDidSelected(with tag: Int) {
        navigationAction = .present(view: .dismissSheet)
    }
    
    func newPeriodCreated() {
        navigateToCreateNewPeriod()
    }
    
    func datePeriodSelected(startDate: Date, endDate: Date) {
        print("start date: \(startDate)")
        print("end date: \(endDate)")
        popToMainScreen()
    }
}

extension MainContainerViewModel: GoToPostDetailsNavigator, GoToCreateNewPeriodNavigator {}
