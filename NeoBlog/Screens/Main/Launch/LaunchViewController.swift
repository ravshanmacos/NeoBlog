//
//  LaunchViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import SwiftEntryKit
import Combine

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
    
    private var subscriptions = Set<AnyCancellable>()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessage()
    }
    
    private func observeErrorMessage() {
        viewModel
            .errorMessages
            .receive(on: DispatchQueue.main)
            .sink {[weak self] message in
                guard let self else { return }
                self.view.showAlert(subtitle: message)
                self.dissmissAlert()
            }.store(in: &subscriptions)
    }
    
    private func dissmissAlert() {
        SwiftEntryKit.dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.errorPresentation.send(.dismissed)
        }
    }
}
