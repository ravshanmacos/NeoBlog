//
//  SignInViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

protocol SignInViewModelFactory {
    func makeSignInViewModel() -> SignInViewModel
}

class SignInViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: SignInViewModelFactory
    private let viewModel: SignInViewModel
    private var signInView: SignInRootView {
        return view as! SignInRootView
    }
    //MARK: Methods
    
    init(viewModelFactory: SignInViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeSignInViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = SignInRootView(viewModel: viewModel)
    }
}
