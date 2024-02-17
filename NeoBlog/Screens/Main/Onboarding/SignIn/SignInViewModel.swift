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
    
    private let signedInResponder: SignedInResponder
    private let goToSendMsgToEmailNavigator: GoToSendMSGToEmailNavigator
    
    //MARK: Methods
    init(signedInResponder: SignedInResponder, goToSendMsgToEmailNavigator: GoToSendMSGToEmailNavigator) {
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
}

//MARK: Actions
@objc extension SignInViewModel {
    func forgotPassword() {
        goToSendMsgToEmailNavigator.navigateSendMsgToEmail()
    }
    
    func signIn() {
       // guard isValidate() else { return }
        print("email: \(email)")
        print("password: \(password)")
        errorMessageSubject.send("Неверный логин или пароль")
    }
}
