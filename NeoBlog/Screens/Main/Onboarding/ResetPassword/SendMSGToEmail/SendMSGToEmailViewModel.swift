//
//  SendMSGToEmail.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import Foundation
import Combine

class SendMSGToEmailViewModel {
    
    //MARK: Properties
    private let userSessionRepository: UserSessionRepository
    private let goToConfirmMsgNavigator: GoToConfirmMSGNavigator
    
    private var errorMessageSubject = PassthroughSubject<String, Never>()
    
    var errorMessagePublisher: AnyPublisher<String, Never> {
        return errorMessageSubject.eraseToAnyPublisher()
    }
    
    @Published private(set) var emailFieldEnabled = true
    @Published private(set) var nextButtonEnabled = false
    
    var email: String = ""
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository,
         goToConfirmMsgNavigator: GoToConfirmMSGNavigator) {
        self.userSessionRepository = userSessionRepository
        self.goToConfirmMsgNavigator = goToConfirmMsgNavigator
    }
    
    func enableNextButton() {
        nextButtonEnabled = true
    }
    
    func disableNextButton() {
        nextButtonEnabled = false
    }
}

@objc extension SendMSGToEmailViewModel {
    func confirmMsg() {
        nextButtonEnabled = false
        guard email.isValidEmail() else {
            errorMessageSubject.send("Введите, пожалуйста, действительный адрес электронной почты!")
            nextButtonEnabled = true
            return
        }
        let requestModel = SendOTPRequestModel(email: email)
        userSessionRepository
            .forgotPassword(reqeustModel: requestModel)
            .done({ result in
                print(result.message)
                self.goToConfirmMsgNavigator.navigateConfirmMsgNavigator(email: self.email)
            })
            .catch { error in
                print(error)
                self.nextButtonEnabled = true
                self.errorMessageSubject.send("Что-то пошло не так. Попробуйте еще раз!")
            }
       
    }
}


