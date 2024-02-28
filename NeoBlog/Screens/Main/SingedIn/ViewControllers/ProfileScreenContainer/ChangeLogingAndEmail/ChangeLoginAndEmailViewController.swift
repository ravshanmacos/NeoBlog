//
//  ChangeLoginAndEmailViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

protocol ChangeLoginAndEmailViewModelFactory {
    func makeChangeLoginAndEmailViewModel() -> ChangeLoginAndEmailViewModel
}

class ChangeLoginAndEmailViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: ChangeLoginAndEmailViewModelFactory
    private let viewModel: ChangeLoginAndEmailViewModel
    private var ChangeLoginAndEmailView: ChangeLoginAndEmailRootView {
        return view as! ChangeLoginAndEmailRootView
    }
    //MARK: Methods
    
    init(viewModelFactory: ChangeLoginAndEmailViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeChangeLoginAndEmailViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = ChangeLoginAndEmailRootView(viewModel: viewModel)
    }
}
