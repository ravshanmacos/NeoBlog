//
//  OnboardingViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import Combine

protocol OnboardingViewControllerFactory {
    func makeWelcomeViewController() -> WelcomeViewController
    func makeSignInViewController() -> SignInViewController
    func makeSignUpViewController() -> SignUpViewController
    func makeSendMsgtoEmailViewController() -> SendMSGToEmailViewController
    func makeConfirmMsgViewController(email: String) -> ConfirmMSGViewController
    func makeCreateNewPasswordViewController(userSession: UserSession) -> CreateNewPasswordViewController
}

class OnboardingViewController: BaseNavigationController {
    
    // MARK: - Properties
    private let viewModel: OnboardingViewModel
    private let viewControllersFactory: OnboardingViewControllerFactory
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Methods
    init(viewModel: OnboardingViewModel,
         viewControllersFactory: OnboardingViewControllerFactory) {
        self.viewModel = viewModel
        self.viewControllersFactory = viewControllersFactory
        super.init()
        self.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationActionPublisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: navigationActionPublisher)
    }
    
    func subscribe(to publisher: AnyPublisher<OnboardingNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: action)
            }.store(in: &subscriptions)
    }
    
    func respond(to navigationAction: OnboardingNavigationAction) {
        switch navigationAction {
        case .present(let view):
            present(view: view)
        case .presented:
            break
        }
    }
    
    func present(view: OnboardingView) {
        switch view {
        case .welcome:
            presentWelcome()
        case .signin:
            presentSignIn()
        case .signup:
            presentSignUp()
        case .sendMSGToEmail:
            presentSendMsgToEmail()
        case .confirmMSG:
            presentConfirmMsg()
        case .createNewPassword:
            presentCreateNewPassword()
        case .popCurrent:
            popToCurrentVC()
        case .popToRoot:
            popToRootVC()
        }
    }
    
    func presentWelcome() {
        let welcomeVC = viewControllersFactory.makeWelcomeViewController()
        pushViewController(welcomeVC, animated: false)
    }
    
    func presentSignIn() {
        let signInVC = viewControllersFactory.makeSignInViewController()
        pushViewController(signInVC, animated: true)
    }
    
    func presentSignUp() {
        let signUpVC = viewControllersFactory.makeSignUpViewController()
        pushViewController(signUpVC, animated: true)
    }
    
    func presentSendMsgToEmail() {
        let sendMsgToEmailVC = viewControllersFactory.makeSendMsgtoEmailViewController()
        pushViewController(sendMsgToEmailVC, animated: true)
    }
    
    func presentConfirmMsg() {
        guard let email = viewModel.email else { return }
        let confirmMsgViewController = viewControllersFactory.makeConfirmMsgViewController(email: email)
        pushViewController(confirmMsgViewController, animated: true)
    }
    
    func presentCreateNewPassword() {
        guard let userSession = viewModel.userSession else { return }
        let createNewPasswordVC = viewControllersFactory.makeCreateNewPasswordViewController(userSession: userSession)
        pushViewController(createNewPasswordVC, animated: true)
    }
    
    func popToCurrentVC() {
        popViewController(animated: true)
    }
    
    func popToRootVC() {
        popToRootViewController(animated: true)
    }
}

// MARK: - Navigation Bar Presentation
extension OnboardingViewController {
    
    func hideOrShowNavigationBarIfNeeded(for view: OnboardingView, animated: Bool) {
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
extension OnboardingViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        guard let viewToBeShown = onboardingView(associatedWith: viewController) else { return }
        hideOrShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let shownView = onboardingView(associatedWith: viewController) else { return }
        viewModel.uiPresented(onboardingView: shownView)
    }
}

extension OnboardingViewController {
    
    func onboardingView(associatedWith viewController: UIViewController) -> OnboardingView? {
        switch viewController {
        case is WelcomeViewController:
            return .welcome
        case is SignInViewController:
            return .signin
        case is SignUpViewController:
            return .signup
        case is SendMSGToEmailViewController:
            return .sendMSGToEmail
        case is ConfirmMSGViewController:
            return .confirmMSG
        case is CreateNewPasswordViewController:
            return .createNewPassword
        default:
            assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
            return nil
        }
    }
}

