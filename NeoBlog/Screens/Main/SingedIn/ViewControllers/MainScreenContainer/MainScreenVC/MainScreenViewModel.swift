//
//  MainScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation

class MainScreenViewModel {
    
    //MARK: Properties
    private let goToPostDetailsNavigator: GoToPostDetailsNavigator
    
    //MARK: Methods
    init(goToPostDetailsNavigator: GoToPostDetailsNavigator) {
        self.goToPostDetailsNavigator = goToPostDetailsNavigator
    }
    
    func navigateToPostDetails(with postID: Int) {
        goToPostDetailsNavigator.navigateToPostDetails()
    }
}
