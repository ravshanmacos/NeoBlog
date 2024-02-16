//
//  LaunchViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

protocol LaunchViewModelFactory {
    func makeLaunchViewModel() -> LaunchViewModel
}

class LaunchViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: LaunchViewModelFactory
    private let viewModel: LaunchViewModel
    private var launchView: LaunchRootView {
        return view as! LaunchRootView
    }
    //MARK: Methods
    
    init(viewModelFactory: LaunchViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeLaunchViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = LaunchRootView(viewModel: viewModel)
    }
}
