//
//  ConfirmMSGViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

protocol ConfirmMSGViewModelFactory {
    func makeConfirmMsgViewModel() -> ConfirmMSGViewModel
}

class ConfirmMSGViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: ConfirmMSGViewModelFactory
    private let viewModel: ConfirmMSGViewModel
    private var confirmMSGView: ConfirmMSGRootView {
        return view as! ConfirmMSGRootView
    }
    //MARK: Methods
    
    init(viewModelFactory: ConfirmMSGViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeConfirmMsgViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = ConfirmMSGRootView(viewModel: viewModel)
    }
}
