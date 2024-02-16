//
//  SignUpViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class SignUpViewModel {
    
    //MARK: Properties
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    @Published private(set) var authErrors: AuthErrors = .initial
    
    //MARK: Methods
    
    func signUp() {
        guard isValidate() else { return }
        print("username: \(username)")
        print("email: \(email)")
        print("password: \(password)")
        print("confirpassword: \(confirmPassword)")
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
