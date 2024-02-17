//
//  SendMSGToEmailViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

protocol SendMSGToEmailViewModelFactory {
    func makeSendMsgToEmailViewModel() -> SendMSGToEmailViewModel
}

class SendMSGToEmailViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: SendMSGToEmailViewModelFactory
    private let viewModel: SendMSGToEmailViewModel
    private var sendMSGToEmailView: SendMSGToEmailRootView {
        return view as! SendMSGToEmailRootView
    }
    //MARK: Methods
    
    init(viewModelFactory: SendMSGToEmailViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeSendMsgToEmailViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = SendMSGToEmailRootView(viewModel: viewModel)
    }
}
