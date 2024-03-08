//
//  ChangePasswordViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import Foundation
import Combine

class ChangePasswordViewModel {
    
    //MARK: Properties
    @Published private(set) var authErrors: AuthErrors = .initial
    @Published private(set) var saveBtnEnabled = false
    
    private var successMessageSubject = PassthroughSubject<String, Never>()
    
    var successMessagePublisher: AnyPublisher<String, Never> {
        successMessageSubject.eraseToAnyPublisher()
    }
    
    private let postRepository: PostRepository
    private let goToMainScreenNavigator: GoToMainScreenNavigator
    
    var currentPassword: String = "" {didSet{ checkFields() }}
    var password: String = "" {didSet{ checkFields() }}
    var confirmPassword: String = "" {didSet{ checkFields() }}
    
    
    //MARK: Methods
    init(postRepository: PostRepository, goToMainScreenNavigator: GoToMainScreenNavigator) {
        self.postRepository = postRepository
        self.goToMainScreenNavigator = goToMainScreenNavigator
    }
    
    @objc func save() {
        guard isValidate() else { return }
        print("currentPassword: \(currentPassword)")
        print("password: \(password)")
        print("confirpassword: \(confirmPassword)")
        let requestModel = UpdatePasswordRequestModel(oldPassword: currentPassword, newPassword: password, confirmPassword: confirmPassword)
        postRepository
            .updatePassword(requestModel: requestModel)
            .done { message in
                self.successMessageSubject.send("Пароль успешно изменен")
                DispatchQueue.main.asyncAfter(wallDeadline: .now()+0.5) {
                    self.goToMainScreenNavigator.navigateToMainScreen(newUsername: nil, newEmail: nil)
                }
            }.catch { error in
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
    
    private func checkFields() {
        if currentPassword != "" &&
            password != "" &&
            confirmPassword != "" {
            saveBtnEnabled = true
        } else {
            saveBtnEnabled = false
        }
    }
}
