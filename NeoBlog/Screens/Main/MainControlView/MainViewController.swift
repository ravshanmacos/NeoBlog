//
//  MainViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import Combine

protocol MainViewControllerFactory {
    func makeLaunchViewController() -> LaunchViewController
    func makeOnboardingViewController() -> OnboardingViewController
    func makeSignedInViewController() -> TabBarController
}

class MainViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModel: MainViewModel
    private let viewControllersFactory: MainViewControllerFactory
    
    //child view controllers
    private let launchViewController: LaunchViewController
    private var onboardingViewController: OnboardingViewController?
    private var signedInViewController: TabBarController?
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewModel: MainViewModel, viewControllersFactory: MainViewControllerFactory) {
        self.viewModel = viewModel
        self.viewControllersFactory = viewControllersFactory
        self.launchViewController = viewControllersFactory.makeLaunchViewController()
        self.onboardingViewController = viewControllersFactory.makeOnboardingViewController()
        self.signedInViewController = viewControllersFactory.makeSignedInViewController()
        super.init()
    }
    
    func subscribe(to publisher: AnyPublisher<MainViewState, Never>) {
      publisher
        .receive(on: DispatchQueue.main)
        .sink { [weak self] view in
          guard let strongSelf = self else { return }
          strongSelf.present(view)
        }.store(in: &subscriptions)
    }

    public func present(_ view: MainViewState) {
      switch view {
      case .launching:
        presentLaunching()
      case .onboarding:
        if onboardingViewController?.presentingViewController == nil {
          if presentedViewController.exists {
            // Dismiss profile modal when signing out.
            dismiss(animated: true) { [weak self] in
              self?.presentOnboarding()
            }
          } else {
            presentOnboarding()
          }
        }
      case .signedIn:
        presentSignedIn()
      }
    }

    public func presentLaunching() {
        let launchVC = viewControllersFactory.makeLaunchViewController()
      addFullScreen(childViewController: launchVC)
    }

    public func presentOnboarding() {
        let onboardingViewController = viewControllersFactory.makeOnboardingViewController()
      onboardingViewController.modalPresentationStyle = .fullScreen
      present(onboardingViewController, animated: true) { [weak self] in
        guard let strongSelf = self else {
          return
        }

        strongSelf.remove(childViewController: strongSelf.launchViewController)
        if let signedInViewController = strongSelf.signedInViewController {
          strongSelf.remove(childViewController: signedInViewController)
          strongSelf.signedInViewController = nil
        }
      }
      self.onboardingViewController = onboardingViewController
    }

    public func presentSignedIn() {
      remove(childViewController: launchViewController)

      let signedInViewControllerToPresent: TabBarController
      if let vc = self.signedInViewController {
        signedInViewControllerToPresent = vc
      } else {
          signedInViewControllerToPresent = viewControllersFactory.makeSignedInViewController()
        self.signedInViewController = signedInViewControllerToPresent
      }

      addFullScreen(childViewController: signedInViewControllerToPresent)

      if onboardingViewController?.presentingViewController != nil {
        onboardingViewController = nil
        dismiss(animated: true)
      }
    }

    public override func viewDidLoad() {
      super.viewDidLoad()
      observeViewModel()
    }

    private func observeViewModel() {
      let publisher = viewModel.$view.removeDuplicates().eraseToAnyPublisher()
      subscribe(to: publisher)
    }
}
