//
//  MainScreenContainerViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import UIKit
import SwiftEntryKit
import Combine

protocol ProfileContainerViewControllerFactory {
    func makeProfileScreenViewController(userProfile: UserProfile) -> ProfileScreenViewController 
    func makeEditProfileSheet() -> EditProfileSheet
    func makeEditProfileVC() -> EditProfileViewController
    func makeChangeLoginAndEmail() -> ChangeLoginAndEmailViewController 
    func makeChangePassword() -> ChangePasswordViewController
}

class ProfileContainerViewController: BaseNavigationController {
    
    //MARK: Properties
    private let viewModel: ProfileContainerViewModel
    private let factory: ProfileContainerViewControllerFactory
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewModel: ProfileContainerViewModel, factory: ProfileContainerViewControllerFactory) {
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
    
    func subscribe(to publisher: AnyPublisher<ProfileContainerNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: action)
            }.store(in: &subscriptions)
    }
    
    func respond(to navigationAction: ProfileContainerNavigationAction) {
        switch navigationAction {
        case .present(let view):
            present(view: view)
        case .presented:
            break
        }
    }
    
    func present(view: ProfileContainerViewState) {
        switch view {
        case .mainScreen: presentProfileScreenViewController()
        case .editProfile: presentEditProfileSheet()
        case .editProfileVC: presentEditProfileVC()
        case .changeLoginAndEmail: presentChangeLoginAndEmail()
        case .changePassword: presentChangePassword()
        case .logout: presentLogout()
        case .dissmissCurrentView: dissmissCurrentView()
        }
    }
    
    private func presentProfileScreenViewController() {
        let profileVC = factory.makeProfileScreenViewController(userProfile: viewModel.userProfile)
        pushViewController(profileVC, animated: true)
    }
    
    private func presentEditProfileSheet() {
        let editProfileSheet = factory.makeEditProfileSheet()
        presentPanModal(editProfileSheet)
    }
    
    private func presentEditProfileVC() {
        let editProfileVC = factory.makeEditProfileVC()
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            pushViewController(editProfileVC, animated: true)
        }
    }
    
    private func presentChangeLoginAndEmail() {
        let changeLoginAndEmailVC = factory.makeChangeLoginAndEmail()
        pushViewController(changeLoginAndEmailVC, animated: true)
    }
    
    private func presentChangePassword() {
        let changePasswordVC = factory.makeChangePassword()
        pushViewController(changePasswordVC, animated: true)
    }
    
    private func presentLogout() {
        print("Logout Tapped")
    }
    
    private func dissmissCurrentView() {
        dismiss(animated: true)
    }
}

// MARK: - Navigation Bar Presentation
extension ProfileContainerViewController {
    
    func hideOrShowNavigationBarIfNeeded(for view: ProfileContainerViewState, animated: Bool) {
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
extension ProfileContainerViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        guard let viewToBeShown = ProfileContainerView(associatedWith: viewController) else { return }
        hideOrShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let shownView = ProfileContainerView(associatedWith: viewController) else { return }
        viewModel.uiPresented(ProfileContainerViewState: shownView)
    }
}

extension ProfileContainerViewController {
    func ProfileContainerView(associatedWith viewController: UIViewController) -> ProfileContainerViewState? {
        switch viewController {
        case is ProfileScreenViewController:
            return .mainScreen
        case is EditProfileViewController:
            return .editProfileVC
        case is ChangeLoginAndEmailViewController:
            return .changeLoginAndEmail
        case is ChangePasswordViewController:
            return .changePassword
        default:
            assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
            return nil
        }
    }
}
