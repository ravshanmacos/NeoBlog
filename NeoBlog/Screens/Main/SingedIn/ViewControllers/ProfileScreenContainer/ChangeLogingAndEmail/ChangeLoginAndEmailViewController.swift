//
//  ChangeLoginAndEmailViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit
import Combine

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
    
    private var subscriptions = Set<AnyCancellable>()
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
