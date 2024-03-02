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

protocol MainScreenViewControllerFactory {
    func makeSortByDateSheet() -> SortByDateSheet
    func makePostCollectionSheet() -> PostCollectionSheet
}

class MainScreenViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: MainScreenViewModelFactory
    private let viewControllersFactory: MainScreenViewControllerFactory
    private let viewModel: MainScreenViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    
    init(viewModelFactory: MainScreenViewModelFactory, viewControllersFactory: MainScreenViewControllerFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewControllersFactory = viewControllersFactory
        self.viewModel = viewModelFactory.makeMainScreenViewModel()
        super.init()
        observeViewState()
    }
    
    override func loadView() {
        super.loadView()
        self.view = MainScreenRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getBlogPostList()
    }
    
    private func observeViewState() {
        viewModel
            .$view
            .receive(on: DispatchQueue.main)
            .sink {[weak self] view in
                guard let self else { return }
                self.present(view)
            }.store(in: &subscriptions)
    }
    
    private func present(_ view: MainScreenViewState) {
        switch view {
        case .initial:
            print("Initial")
        case .sortByCategorySheet:
            presentSortByDateSheet()
        case .postsCollectionSheet:
            presentPostCollectionSheet()
        }
    }
    
    private func presentSortByDateSheet() {
        let sortByDateSheet = viewControllersFactory.makeSortByDateSheet()
        navigationController?.presentPanModal(sortByDateSheet)
    }
    
    private func presentPostCollectionSheet() {
        let postCollectionSheet = viewControllersFactory.makePostCollectionSheet()
        navigationController?.presentPanModal(postCollectionSheet)
    }
}
