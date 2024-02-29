//
//  SignUpViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation
import Combine

class SignUpViewModel {
    
    //MARK: Properties
    private let userSessionRepository: UserSessionRepository
    private let popCurrentResponder: PopCurrentResponder
    private let goToSignInNavigator: GoToSignInNavigator
    
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    @Published private(set) var authErrors: AuthErrors = .initial
    private var errorMessageSubject = PassthroughSubject<String, Never>()
    
    var errorMessagePublisher: AnyPublisher<String, Never> {
        return errorMessageSubject.eraseToAnyPublisher()
    }
    
    //MARK: Methods
    
    init(userSessionRepository: UserSessionRepository, 
         popCurrentResponder: PopCurrentResponder,
         goToSignInNavigator: GoToSignInNavigator) {
        self.userSessionRepository = userSessionRepository
        self.popCurrentResponder = popCurrentResponder
        self.goToSignInNavigator = goToSignInNavigator
    }
    
    func signUp() {
        guard isValidate() else { return }
        print("username: \(username)")
        print("email: \(email)")
        print("password: \(password)")
        print("confirpassword: \(confirmPassword)")
        let requestModel = SignUpRequestModel(email: email, username: username, password: password, confirmPassword: confirmPassword)
        userSessionRepository
            .signUp(requestModel: requestModel)
            .done({ message in
                print(message)
                self.popCurrentResponder.popToCurrentView()
                self.goToSignInNavigator.navigateToSignIn()
            })
            .catch { error in
                print(error)
                self.errorMessageSubject.send("Что-то пошло не так! Пожалуйста, попробуйте еще раз.")
            }
        
    }
    
    private func isValidate() -> Bool {
        guard username.isValidUsername() else {
            authErrors = .InvalidUsername
            return false
        }
        
        guard email.isValidEmail() else {
            authErrors = .InvalidEmail
            return false
        }
        
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
