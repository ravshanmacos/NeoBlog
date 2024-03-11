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
    
    var post: BlogPost?
    var postID: Int?
    
    //MARK: Methods
    
    //Navigate To Post Details
    func navigateToPostDetails(postID: Int) {
        self.postID = postID
        navigationAction = .present(view: .postDetails)
    }
    
    //Navigate To Add Post
    func navigateToAddPost(post: BlogPost) {
        self.post = post
        navigationAction = .present(view: .addPostScreen)
    }
    
    //Closing navigation
    func dissmissSheet() {
        navigationAction = .present(view: .dismissSheet)
    }

    //Navigate To Previous
    func popCurrent() {
        navigationAction = .present(view: .popCurrent)
    }
    
    //Navigate To Main
    func popToMainScreen() {
        navigationAction = .present(view: .popToMainScreen)
    }
    
    func uiPresented(mainContainerViewState: MainContainerViewState) {
        navigationAction = .presented(view: mainContainerViewState)
    }
}

//MARK: Responders
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

extension MainContainerViewModel: GoToPostDetailsNavigator, GoToAddPostNavigator {}
