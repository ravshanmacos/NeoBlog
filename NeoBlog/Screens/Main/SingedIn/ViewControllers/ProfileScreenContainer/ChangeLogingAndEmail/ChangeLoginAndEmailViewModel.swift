//
//  ChangeLoginAndEmailViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import Foundation
import Combine

class ChangeLoginAndEmailViewModel {
    
    //MARK: Properties
    private let signedInResponder: SignedInResponder
    
    var password: String = ""
    var confirmPassword: String = ""
    
    @Published private(set) var authErrors: AuthErrors = .initial
    
    var successMessagePublisher: AnyPublisher<String, Never> {
        successMessageSubject.eraseToAnyPublisher()
    }
    
    private var successMessageSubject = PassthroughSubject<String, Never>()
    
    //MARK: Methods
    init(signedInResponder: SignedInResponder) {
        self.signedInResponder = signedInResponder
    }
    
    @objc func save() {
        guard isValidate() else { return }
        print("password: \(password)")
        print("confirpassword: \(confirmPassword)")
//        successMessageSubject.send("Пароль успешно изменен")
//        signedInResponder.signedIn(userSession: <#UserSession#>)
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
