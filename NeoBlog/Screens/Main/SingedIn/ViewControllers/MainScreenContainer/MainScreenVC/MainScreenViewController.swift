//
//  MainScreenViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit
import PanModal
import Combine

protocol MainScreenViewModelFactory {
    func makeMainScreenViewModel() -> MainScreenViewModel
}

class MainScreenViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: MainScreenViewModelFactory
    private let viewModel: MainScreenViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    
    init(viewModelFactory: MainScreenViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeMainScreenViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = MainScreenRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
