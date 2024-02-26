//
//  SortByPeriodViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 24/02/24.
//

import UIKit
import Combine

protocol SortByPeriodViewModelFactory {
    func makeSortByPeriodViewModel() -> SortByPeriodViewModel
}

protocol SortByPeriodViewControllerFactory {
    func makeChooseDateViewController(periodType: PeriodType) -> ChooseDateViewController
}

class SortByPeriodViewController: BaseViewController {
    //MARK: Properties
    
    private let viewControllerFactory: SortByPeriodViewControllerFactory
    private let viewModelFactory: SortByPeriodViewModelFactory
    private let viewModel: SortByPeriodViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewControllerFactory: SortByPeriodViewControllerFactory, 
         viewModelFactory: SortByPeriodViewModelFactory) {
        self.viewControllerFactory = viewControllerFactory
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeSortByPeriodViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = SortByPeriodRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Период"
        subscribe()
    }
    
    private func subscribe() {
        viewModel
            .$navigateForPeriod
            .receive(on: DispatchQueue.main)
            .sink {[weak self] periodType in
                guard let self, let periodType else { return }
                self.presentChooseDate(for: periodType)
            }.store(in: &subscriptions)
    }
    
    private func presentChooseDate(for periodType: PeriodType) {
        let chooseDateVC = viewControllerFactory.makeChooseDateViewController(periodType: periodType)
        chooseDateVC.modalPresentationStyle = .overFullScreen
        chooseDateVC.delegate = self
        present(chooseDateVC, animated: true)
    }
}

extension SortByPeriodViewController: ChooseDateViewDelegate {
    func dateDidSelected(date: Date, periodType: PeriodType) {
        switch periodType {
        case .start: viewModel.startPeriod = date
        case .end: viewModel.endPeriod = date
        }
    }
}
