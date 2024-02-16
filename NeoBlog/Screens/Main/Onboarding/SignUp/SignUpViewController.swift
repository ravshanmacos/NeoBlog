//
//  SignUpViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

protocol SignUpViewModelFactory {
    func makeSignUpViewModel() -> SignUpViewModel
}

class SignUpViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: SignUpViewModelFactory
    private let viewModel: SignUpViewModel
    private var signUpView: SignUpRootView {
        return view as! SignUpRootView
    }
    //MARK: Methods
    
    init(viewModelFactory: SignUpViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeSignUpViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = SignUpRootView(viewModel: viewModel)
    }
}
