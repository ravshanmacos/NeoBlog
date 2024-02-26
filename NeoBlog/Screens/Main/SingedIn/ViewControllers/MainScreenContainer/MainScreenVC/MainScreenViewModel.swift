//
//  MainScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Combine

class MainScreenViewModel {
    
    //MARK: Properties
    
    private let goToPostDetailsNavigator: GoToPostDetailsNavigator
    private let goToSortByDateNavigator: GoToSortByDateSheetNavigator
    private let goToPostCollectionNavigator: GoToPostCollectionNavigator
    
    //MARK: Methods
    
    init(goToPostDetailsNavigator: GoToPostDetailsNavigator,
         goToSortByDateNavigator: GoToSortByDateSheetNavigator,
         goToPostCollectionNavigator: GoToPostCollectionNavigator) {
        self.goToPostDetailsNavigator = goToPostDetailsNavigator
        self.goToSortByDateNavigator = goToSortByDateNavigator
        self.goToPostCollectionNavigator = goToPostCollectionNavigator
    }
    
    func navigateToPostDetails(with postID: Int) {
        goToPostDetailsNavigator.navigateToPostDetails()
    }
    
    // Open sheets
    func openFilterSheet() {
        goToSortByDateNavigator.navigateToSortByDateSheet()
    }
    
    func openPostCollectionSheet() {
        goToPostCollectionNavigator.navigateToPostCollection()
    }
}
