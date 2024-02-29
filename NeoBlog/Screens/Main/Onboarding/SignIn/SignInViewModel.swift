//
//  SignInViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation
import Combine

class SignInViewModel {
    
    //MARK: Properties
    var email: String = "" {
        didSet {
            checkField()
        }
    }
    var password: String = "" {
        didSet {
            checkField()
        }
    }
    
    @Published private(set) var emailFieldEnabled = true
    @Published private(set) var passwordFieldEnabled = true
    @Published private(set) var signInButtonEnabled = false
    
    private var errorMessageSubject = PassthroughSubject<String, Never>()
    
    var errorMessagePublisher: AnyPublisher<String, Never> {
        return errorMessageSubject.eraseToAnyPublisher()
    }
    
    private let userSessionRepository: UserSessionRepository
    private let signedInResponder: SignedInResponder
    private let goToSendMsgToEmailNavigator: GoToSendMSGToEmailNavigator
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository,
         signedInResponder: SignedInResponder,
         goToSendMsgToEmailNavigator: GoToSendMSGToEmailNavigator) {
        self.userSessionRepository = userSessionRepository
        self.signedInResponder = signedInResponder
        self.goToSendMsgToEmailNavigator = goToSendMsgToEmailNavigator
    }
    
    private func checkField() {
        if email != "" && password != "" {
            signInButtonEnabled = true
        } else {
            signInButtonEnabled = false
        }
    }
    
    private func showError(error: Error) {
        print(error)
        self.errorMessageSubject.send("Неверный логин или пароль")
    }
}

//MARK: Actions
@objc extension SignInViewModel {
    func forgotPassword() {
        goToSendMsgToEmailNavigator.navigateSendMsgToEmail()
    }
    
    func signIn() {
        let requestModel = SignInRequestModel(email: email, password: password)
        userSessionRepository
            .signIn(requestModel: requestModel)
            .done(signedInResponder.signedIn(userSession:))
            .catch(showError(error:))
    }
}
