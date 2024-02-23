//
//  MainScreenContainerViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import UIKit
import Combine

protocol MainContainerViewControllerFactory {
    func makeMainScreenViewController() -> MainScreenViewController
    func makePostDetailsViewController() -> PostDetailScreenViewController
}

class MainContainerViewController: BaseNavigationController {
    
    //MARK: Properties
    private let viewModel: MainContainerViewModel
    private let factory: MainContainerViewControllerFactory
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewModel: MainContainerViewModel, factory: MainContainerViewControllerFactory) {
        self.viewModel = viewModel
        self.factory = factory
        super.init()
        self.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let navigationActionPublisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: navigationActionPublisher)
    }
    
    func subscribe(to publisher: AnyPublisher<MainContainerNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: action)
            }.store(in: &subscriptions)
    }
    
    func respond(to navigationAction: MainContainerNavigationAction) {
        switch navigationAction {
        case .present(let view):
            present(view: view)
        case .presented:
            break
        }
    }
    
    func present(view: MainContainerViewState) {
        switch view {
        case .mainScreen:
            presentMainScreenViewController()
        case .postDetails:
            presentPostDetailsScreenViewController()
        }
    }
    
    private func presentMainScreenViewController() {
        let mainVC = factory.makeMainScreenViewController()
        pushViewController(mainVC, animated: true)
    }
    
    private func presentPostDetailsScreenViewController() {
        let postDetailsVC = factory.makePostDetailsViewController()
        tabBarController?.tabBar.isHidden = true
        pushViewController(postDetailsVC, animated: true)
    }
}

// MARK: - Navigation Bar Presentation
extension MainContainerViewController {
    
    func hideOrShowNavigationBarIfNeeded(for view: MainContainerViewState, animated: Bool) {
        if view.hidesNavigationBar() {
            hideNavigationBar(animated: animated)
        } else {
            showNavigationBar(animated: animated)
        }
    }
    
    func hideNavigationBar(animated: Bool) {
        if animated {
            transitionCoordinator?.animate(alongsideTransition: { context in
                self.setNavigationBarHidden(true, animated: animated)
            })
        } else {
            setNavigationBarHidden(true, animated: false)
        }
    }
    
    func showNavigationBar(animated: Bool) {
        if self.isNavigationBarHidden {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension MainContainerViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        guard let viewToBeShown = mainContainerView(associatedWith: viewController) else { return }
        hideOrShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let shownView = mainContainerView(associatedWith: viewController) else { return }
        viewModel.uiPresented(mainContainerViewState: shownView)
    }
}

extension MainContainerViewController {
    func mainContainerView(associatedWith viewController: UIViewController) -> MainContainerViewState? {
        switch viewController {
        case is MainScreenViewController:
            return .mainScreen
        case is PostDetailScreenViewController:
            return .postDetails
        default:
            assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
            return nil
        }
    }
}
