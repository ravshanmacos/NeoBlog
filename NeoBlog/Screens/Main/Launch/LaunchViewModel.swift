//
//  LaunchViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation
import Combine

class LaunchViewModel {
    
    //MARK: Properties
    private let userSessionRepository: UserSessionRepository
    private let notSignedInResponder: NotSignedInResponder
    private let signedInResponder: SignedInResponder
    
    
    private var errorMessageSubject = PassthroughSubject<String, Never>()
    
    var errorMessages: AnyPublisher<String, Never> {
        return errorMessageSubject.eraseToAnyPublisher()
    }
    
    var errorPresentation = PassthroughSubject<ErrorPresentation?, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository,
        notSignedInResponder: NotSignedInResponder,
         signedInResponder: SignedInResponder) {
        self.userSessionRepository = userSessionRepository
        self.notSignedInResponder = notSignedInResponder
        self.signedInResponder = signedInResponder
    }
    
    func loadUserSession() {
        userSessionRepository.readUserSession()
            .done(goToNextScreen(userSession:))
            .catch(presentError(error:))
    }
    
    func presentError(error: Error) {
        goToNextScreenAfterErrorPresentation()
        print(error)
        errorMessageSubject.send("К сожалению, нам не удалось определить, вошли ли вы уже в систему.")
    }
    
    func goToNextScreenAfterErrorPresentation() {
        errorPresentation
            .filter { $0 == .dismissed }
            .prefix(1)
            .sink {[weak self] _ in
                guard let self else { return }
                goToNextScreen(userSession: nil)
            }.store(in: &subscriptions)
    }
    
    func goToNextScreen(userSession: UserSession?) {
        switch userSession {
        case .none:
            notSignedInResponder.notSignedIn()
        case .some(let userSession):
            signedInResponder.signedIn(userSession: userSession)
        }
    }
}
