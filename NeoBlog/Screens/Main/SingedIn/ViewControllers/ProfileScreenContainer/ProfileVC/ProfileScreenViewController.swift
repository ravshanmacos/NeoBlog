//
//  ProfileScreenViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

protocol ProfileViewModelFactory {
    func makeProfileViewModel() -> ProfileScreenViewModel
}

class ProfileScreenViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: ProfileViewModelFactory
    private let viewModel: ProfileScreenViewModel
    
    //MARK: Methods
    
    init(viewModelFactory: ProfileViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeProfileViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = ProfileScreenRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMyPosts()
    }
}
