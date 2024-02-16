//
//  WelcomeViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

protocol WelcomeViewModelFactory {
    func makeWelcomeViewModel() -> WelcomeViewModel
}

class WelcomeViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: WelcomeViewModelFactory
    private let viewModel: WelcomeViewModel
    private var welcomeView: WelcomeRootView {
        return view as! WelcomeRootView
    }
    //MARK: Methods
    
    init(viewModelFactory: WelcomeViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeWelcomeViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = WelcomeRootView(viewModel: viewModel)
    }
}
