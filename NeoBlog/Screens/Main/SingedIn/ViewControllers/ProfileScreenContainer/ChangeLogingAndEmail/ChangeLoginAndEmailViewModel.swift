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
    
    @Published private(set) var authErrors: AuthErrors = .initial
    
    var successMessagePublisher: AnyPublisher<String, Never> {
        successMessageSubject.eraseToAnyPublisher()
    }
    
    private var successMessageSubject = PassthroughSubject<String, Never>()
    
    private let postRepository: PostRepository
    private let goToMainScreenNavigator: GoToMainScreenNavigator
    
    var login: String = ""
    var email: String = ""
    
    //MARK: Methods
    init(postRepository: PostRepository, goToMainScreenNavigator: GoToMainScreenNavigator) {
        self.postRepository = postRepository
        self.goToMainScreenNavigator = goToMainScreenNavigator
    }
    
    @objc func save() {
        guard isValidate() else { return }
        postRepository
            .updateLoginAndEmail(requestModel: .init(username: login, email: email))
            .done { result in
                self.successMessageSubject.send("Логин и электронная почта успешно изменены")
                DispatchQueue.main.asyncAfter(wallDeadline: .now()+0.5) {
                    self.goToMainScreenNavigator.navigateToMainScreen(newUsername: self.login, newEmail: self.email)
                }
            }.catch { error in
               print(error)
            }
    }
    
    private func isValidate() -> Bool {
        guard login.isValidUsername() else {
            authErrors = .InvalidUsername
            return false
        }
    
        guard email.isValidEmail() else {
            authErrors = .InvalidEmail
            return false
        }
        
        return true
    }
}
