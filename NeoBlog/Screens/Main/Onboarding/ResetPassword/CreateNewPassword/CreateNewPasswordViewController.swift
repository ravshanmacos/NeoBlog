//
//  CreateNewPasswordViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

protocol CreateNewPasswordViewModelFactory {
    func makeCreateNewPasswordViewModel() -> CreateNewPasswordViewModel
}

class CreateNewPasswordViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: CreateNewPasswordViewModelFactory
    private let viewModel: CreateNewPasswordViewModel
    private var createNewPasswordView: CreateNewPasswordRootView {
        return view as! CreateNewPasswordRootView
    }
    //MARK: Methods
    
    init(userSession: UserSession, viewModelFactory: CreateNewPasswordViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeCreateNewPasswordViewModel()
        self.viewModel.userSession = userSession
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = CreateNewPasswordRootView(viewModel: viewModel)
    }
}
