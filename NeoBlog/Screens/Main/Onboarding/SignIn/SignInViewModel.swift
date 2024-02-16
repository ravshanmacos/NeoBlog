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
    var email: String = ""
    var password: String = ""
    
    @Published private(set) var emailFieldEnabled = true
    @Published private(set) var passwordFieldEnabled = true
    @Published private(set) var signInButtonEnabled = false
    
    var errorMessagePublisher: AnyPublisher<String, Never> {
        return errorMessageSubject.eraseToAnyPublisher()
    }
    private var errorMessageSubject = PassthroughSubject<String, Never>()
    
    //MARK: Methods
    func signUp() {
        guard isValidate() else { return }
        print("email: \(email)")
        print("password: \(password)")
    }
    
    private func isValidate() -> Bool {
        
        return true
    }
}
