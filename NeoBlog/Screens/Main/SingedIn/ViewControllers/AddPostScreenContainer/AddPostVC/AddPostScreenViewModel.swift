//
//  AddPostScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation

class AddPostScreenViewModel {
    
    //MARK: Properties
    private let closeAddPostResponder: CloseAddPostScreenResponder
    
    //MARK: Methods
    init(closeAddPostResponder: CloseAddPostScreenResponder) {
        self.closeAddPostResponder = closeAddPostResponder
    }
    
    @objc func closeBtnTapped() {
        closeAddPostResponder.closeAddPostView()
    }
}
