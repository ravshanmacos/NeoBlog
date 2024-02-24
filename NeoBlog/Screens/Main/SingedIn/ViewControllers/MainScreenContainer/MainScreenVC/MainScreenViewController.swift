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
        subscribe()
    }
    
    override func loadView() {
        super.loadView()
        self.view = MainScreenRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func subscribe() {
        viewModel
            .$mainScreenViewState
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink {[weak self] viewState in
                guard let self else { return }
                respond(to: viewState)
            }.store(in: &subscriptions)
    }
    
    private func respond(to viewState: MainScreenViewState) {
        switch viewState {
        case .initial: presentInitialState()
        case .openSortByDateSheet: presentSortByDateSheet()
        case .openPostColllectionSheet: presentPostCollectionSheet()
        }
    }
    
    private func presentInitialState() {
        
    }
    
    private func presentSortByDateSheet() {
        let sortByDateSheet = SortByDateSheet()
        navigationController?.presentPanModal(sortByDateSheet)
    }
    
    private func presentPostCollectionSheet() {
        
    }
}
