//
//  CreateNewPasswordViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import Foundation
import PromiseKit
import Combine

class CreateNewPasswordViewModel {
    
    //MARK: Properties
    private let userSessionRepository: UserSessionRepository
    private let signedInResponder: SignedInResponder
    
    var password: String = ""
    var confirmPassword: String = ""
    
    @Published private(set) var authErrors: AuthErrors = .initial
    
    private var successMessageSubject = PassthroughSubject<String, Never>()
    var successMessagePublisher: AnyPublisher<String, Never> {
        successMessageSubject.eraseToAnyPublisher()
    }
    var userSession: UserSession?
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository, signedInResponder: SignedInResponder) {
        self.userSessionRepository = userSessionRepository
        self.signedInResponder = signedInResponder
    }
    
    @objc func save() {
        guard isValidate(), let userSession else { return }
        let requestModel = ChangeForgotPasswordRequestModel(password: password, confirmPassword: confirmPassword)
        userSessionRepository
            .changeForgotPassword(token: userSession.remoteSession.accessToken, requestModel: requestModel)
            .done({ message in
                print(message)
                self.successMessageSubject.send("Пароль успешно изменен")
                self.signedInResponder.signedIn(userSession: userSession)
            })
            .catch { error in
                print(error)
            }
    }
    
    private func isValidate() -> Bool {
        guard password.isValidPassword() else {
            authErrors = .InvalidPassword
            return false
        }
    
        guard confirmPassword == password else {
            authErrors = .InvalidConfirmPassword
            return false
        }
        
        return true
    }
}
