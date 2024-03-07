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
    func makeSortByDateSheet(createNewPeriodResponder: NewPeriodCreatedResponder, gotToNewPeriodNavigator: GoToCreateNewPeriodNavigator, sortByDateSelectedResponder: SortByDateSelectedResponder) -> SortByDateSheet
    func makeSortByPeriodViewController(dateDidSelectedResponder: DateDidSelectedResponder) -> SortByPeriodViewController
    func makePostCollectionSheet(collectionID: Int?, postID: Int) -> PostCollectionSheet
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        case .dissmiss:
            dismiss(animated: true)
        case .filterByDate:
            presentFilterByDateSheet()
        case .filterByPeriod:
            presentFilterByPeriodSheet()
        case .addPostToCollection(let savedCollectionID, let postID):
            presentPostCollectionSheet(collectionID: savedCollectionID, postID: postID)
        }
    }
    
    private func presentFilterByDateSheet() {
        let sortByDateSheet = viewControllersFactory.makeSortByDateSheet(createNewPeriodResponder: viewModel, gotToNewPeriodNavigator: viewModel, sortByDateSelectedResponder: viewModel)
        navigationController?.presentPanModal(sortByDateSheet)
    }
    
    private func presentFilterByPeriodSheet() {
        dismiss(animated: true) {[weak self] in
            guard let self else { return }
            let filterByPeriodSheet = viewControllersFactory.makeSortByPeriodViewController(dateDidSelectedResponder: viewModel)
            filterByPeriodSheet.modalPresentationStyle = .overFullScreen
            navigationController?.present(filterByPeriodSheet, animated: true)
        }
        
    }
    
    private func presentPostCollectionSheet(collectionID: Int?, postID: Int) {
        let postCollectionSheet = viewControllersFactory.makePostCollectionSheet(collectionID: collectionID, postID: postID)
        navigationController?.presentPanModal(postCollectionSheet)
    }
}
