//
//  ChangePasswordViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

protocol ChangePasswordViewModelFactory {
    func makeChangePasswordViewModel() -> ChangePasswordViewModel
}

class ChangePasswordViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: ChangePasswordViewModelFactory
    private let viewModel: ChangePasswordViewModel
    private var ChangePasswordView: ChangePasswordRootView {
        return view as! ChangePasswordRootView
    }
    //MARK: Methods
    
    init(viewModelFactory: ChangePasswordViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeChangePasswordViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = ChangePasswordRootView(viewModel: viewModel)
    }
}
