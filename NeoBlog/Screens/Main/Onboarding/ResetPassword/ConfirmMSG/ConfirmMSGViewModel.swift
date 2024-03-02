//
//  ConfirmMSGViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import Foundation
import VKPinCodeView

class ConfirmMSGViewModel {
    
    //MARK: Properties
    @Published private(set) var seconds = 60
    @Published private(set) var sendOtpEnabled = true
    
    private let userSessionRepository: UserSessionRepository
    private let goToCreateNewPasswordNavigator: GoToCreateNewPasswordNavigator
    private var timer = Timer()
    private var userSession: UserSession?
    var email: String?
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository,
         goToCreateNewPasswordNavigator: GoToCreateNewPasswordNavigator) {
        self.userSessionRepository = userSessionRepository
        self.goToCreateNewPasswordNavigator = goToCreateNewPasswordNavigator
    }
    
    func isCodeMatch(code: String, _ completion: @escaping ((Bool)->Void)) {
        userSessionRepository
            .verifyOTP(reqeustModel: .init(code: code))
            .done { userSession in
                self.userSession = userSession
                completion(true)
            }.catch { error in
                print(error)
                completion(false)
            }
    }
}

@objc extension ConfirmMSGViewModel {
    func createNewPassword() {
        guard let userSession else { return }
        self.goToCreateNewPasswordNavigator.navigateCreateNewPassword(userSession: userSession)
    }
    
    func sendOtpAgain() {
        guard let email else { return }
        start()
        userSessionRepository
            .forgotPassword(reqeustModel: .init(email: email))
            .done { _ in
                
            }
            .catch { error in
                print(error)
            }
        sendOtpEnabled = false
    }
}

//MARK: Timer
private extension ConfirmMSGViewModel {
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction(){
        if seconds > 0 {
            seconds -= 1
        } else {
            timer.invalidate()
            print("time finished")
            seconds = 10
            sendOtpEnabled = true
        }
       
    }
}
