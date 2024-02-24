//
//  MainScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Combine

enum MainScreenViewState {
    case initial
    case openSortByDateSheet
    case openPostColllectionSheet
}

class MainScreenViewModel {
    
    //MARK: Properties
    
    private let goToPostDetailsNavigator: GoToPostDetailsNavigator
    
    //MARK: Methods
    @Published private(set) var mainScreenViewState: MainScreenViewState = .initial
    
    init(goToPostDetailsNavigator: GoToPostDetailsNavigator) {
        self.goToPostDetailsNavigator = goToPostDetailsNavigator
    }
    
    func navigateToPostDetails(with postID: Int) {
        goToPostDetailsNavigator.navigateToPostDetails()
    }
    
    // Open sheets
    func openFilterSheet() {
        mainScreenViewState = .openSortByDateSheet
    }
    
    func openPostCollectionSheet() {
        mainScreenViewState = .openPostColllectionSheet
    }
}
