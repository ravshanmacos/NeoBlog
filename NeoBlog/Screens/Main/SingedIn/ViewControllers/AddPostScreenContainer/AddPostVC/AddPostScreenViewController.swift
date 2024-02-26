//
//  AddPostScreenViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

protocol AddPostViewModelFactory {
    func makeAddPostViewModel() -> AddPostScreenViewModel
}

class AddPostScreenViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: AddPostViewModelFactory
    private let viewModel: AddPostScreenViewModel
    //MARK: Methods
    
    init(viewModelFactory: AddPostViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeAddPostViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = AddPostScreenRootView(viewModel: viewModel)
    }
}
