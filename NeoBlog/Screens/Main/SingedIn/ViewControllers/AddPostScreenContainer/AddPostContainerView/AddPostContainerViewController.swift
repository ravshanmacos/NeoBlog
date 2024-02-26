//
//  AddPostContainerViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 26/02/24.
//

import Foundation
import Combine
import UIKit

protocol AddPostContainerViewControllerFactory {
    func makeAddPostScreenViewController() -> AddPostScreenViewController
}
 
class AddPostContainerViewController: BaseNavigationController, UITabBarControllerDelegate {
    
    //MARK: Properties
    private let viewModel: AddPostContainerViewModel
    private let viewControllerFactory: AddPostContainerViewControllerFactory
    
    private var subscriptions = Set<AnyCancellable>()
    
     
    //MARK: Methods
    init(viewModel: AddPostContainerViewModel, viewControllerFactory: AddPostContainerViewControllerFactory) {
        self.viewModel = viewModel
        self.viewControllerFactory = viewControllerFactory
        super.init()
        tabBarController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let navigationActionPublisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: navigationActionPublisher)
    }
    
    func subscribe(to publisher: AnyPublisher<AddPostContainerNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: action)
            }.store(in: &subscriptions)
    }
    
    func respond(to navigationAction: AddPostContainerNavigationAction) {
        switch navigationAction {
        case .present(let view):
            present(view: view)
        case .presented:
            break
        }
    }
    
    func present(view: AddPostContainerViewState) {
        switch view {
        case .addPostScreen:
            presentAddPostScreen()
        case .closeAddPostScreen:
            closeAddPostScreen()
        }
    }
    
    private func presentAddPostScreen() {
        let addPostScreenVC = viewControllerFactory.makeAddPostScreenViewController()
        addPostScreenVC.modalPresentationStyle = .overFullScreen
        present(addPostScreenVC, animated: true)
    }
    
    private func closeAddPostScreen() {
        dismiss(animated: true) {
            self.tabBarController?.selectedIndex = 0
        }
    }
}
