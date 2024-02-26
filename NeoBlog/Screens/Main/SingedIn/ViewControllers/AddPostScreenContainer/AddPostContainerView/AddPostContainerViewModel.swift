//
//  AddPostContainerViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 26/02/24.
//

import Foundation

typealias AddPostContainerNavigationAction = NavigationAction<AddPostContainerViewState>

class AddPostContainerViewModel: CloseAddPostScreenResponder {
    //MARK: Properties
    @Published private(set) var navigationAction: AddPostContainerNavigationAction = .present(view: .addPostScreen)
    
    //MARK: Methods
    
    func closeAddPostView() {
        navigationAction = .present(view: .closeAddPostScreen)
    }
}
