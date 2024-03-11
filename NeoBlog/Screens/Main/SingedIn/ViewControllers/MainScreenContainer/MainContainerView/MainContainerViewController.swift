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
    func makeAddPostScreenViewController(byTab: Bool, post: BlogPost?) -> AddPostScreenViewController
    func makePostDetailsViewController(postID: Int) -> PostDetailScreenViewController
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
        case .mainScreen: presentMainScreenViewController()
        case .postDetails: presentPostDetailsScreenViewController()
        case .addPostScreen: presentAddPostScreenViewController()
        case .dismissSheet: dissmissSheet()
        case .popCurrent: popCurrent()
        case .popToMainScreen: popToCurrent()
        }
    }
    
    //Present Main Screen
    private func presentMainScreenViewController() {
        let mainVC = factory.makeMainScreenViewController()
        pushViewController(mainVC, animated: true)
    }
    
    //Present Post Details
    private func presentPostDetailsScreenViewController() {
        guard let postID = viewModel.postID else { return }
        let postDetailsVC = factory.makePostDetailsViewController(postID: postID)
        tabBarController?.tabBar.isHidden = true
        pushViewController(postDetailsVC, animated: true)
    }
    
    //Present Edit Post
    private func presentAddPostScreenViewController() {
        let addPostVC = factory.makeAddPostScreenViewController(byTab: false, post: viewModel.post)
        addPostVC.modalPresentationStyle = .overFullScreen
        present(addPostVC, animated: true)
    }
    
    private func dissmissSheet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true)
        }
    }
    
    private func popCurrent() {
        popViewController(animated: true)
    }
    
    private func popToCurrent() {
        popToRootViewController(animated: true)
    }
}

// MARK: - Navigation Bar Presentation
extension MainContainerViewController {
    
    func hideOrShowNavigationBarIfNeeded(for view: MainContainerViewState, animated: Bool) {
        if view.hidesNavigationBar() {
            hideNavigationBar(animated: animated)
            tabBarController?.tabBar.isHidden = false
        } else {
            showNavigationBar(animated: animated)
            tabBarController?.tabBar.isHidden = true
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
