//
//  OnboardingViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import Combine

class OnboardingViewController: BaseNavigationController {
    
    // MARK: - Properties
    private let viewModel: OnboardingViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // Child View Controllers
    private let welcomeViewController: WelcomeViewController
    private let signInViewController: SignInViewController
    private let signUpViewController: SignUpViewController
    private let sendMsgToEmailViewController: SendMSGToEmailViewController
    private let confirmMsgViewController: ConfirmMSGViewController
    private let createNewPasswordViewController: CreateNewPasswordViewController
    
    // MARK: - Methods
    init(viewModel: OnboardingViewModel,
         welcomeViewController: WelcomeViewController,
         signInViewController: SignInViewController,
         signUpViewController: SignUpViewController,
         sendMsgToEmailViewController: SendMSGToEmailViewController,
         confirmMsgViewController: ConfirmMSGViewController,
         createNewPasswordViewController: CreateNewPasswordViewController) {
        self.viewModel = viewModel
        self.welcomeViewController = welcomeViewController
        self.signInViewController = signInViewController
        self.signUpViewController = signUpViewController
        self.sendMsgToEmailViewController = sendMsgToEmailViewController
        self.confirmMsgViewController = confirmMsgViewController
        self.createNewPasswordViewController = createNewPasswordViewController
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
        pushViewController(welcomeViewController, animated: false)
    }
    
    func presentSignIn() {
        pushViewController(signInViewController, animated: true)
    }
    
    func presentSignUp() {
        pushViewController(signUpViewController, animated: true)
    }
    
    func presentSendMsgToEmail() {
        pushViewController(sendMsgToEmailViewController, animated: true)
    }
    
    func presentConfirmMsg() {
        pushViewController(confirmMsgViewController, animated: true)
    }
    
    func presentCreateNewPassword() {
        guard let userSession = viewModel.userSession else { return }
        pushViewController(createNewPasswordViewController, animated: true)
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

