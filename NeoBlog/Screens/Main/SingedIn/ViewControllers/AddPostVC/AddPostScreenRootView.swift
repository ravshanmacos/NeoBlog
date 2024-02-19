//
//  AddPostScreenRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

class AddPostScreenRootView: BaseView {
    
    //MARK: Properties
    private let viewModel: AddPostScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: AddPostScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
}
