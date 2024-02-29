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
    @Published private(set) var seconds = 10
    @Published private(set) var sendOtpEnabled = true
    
    private let userSessionRepository: UserSessionRepository
    private let goToCreateNewPasswordNavigator: GoToCreateNewPasswordNavigator
    private var timer = Timer()
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository,
         goToCreateNewPasswordNavigator: GoToCreateNewPasswordNavigator) {
        self.userSessionRepository = userSessionRepository
        self.goToCreateNewPasswordNavigator = goToCreateNewPasswordNavigator
    }
    
    func isCodeMatch(code: String) -> Bool {
        var isMatch = false
        userSessionRepository
            .verifyOTP(reqeustModel: .init(code: code))
            .done { userSession in
                isMatch = true
                self.goToCreateNewPasswordNavigator.navigateCreateNewPassword(userSession: userSession)
            }.catch { error in
                print(error)
                isMatch = false
            }
        return isMatch
    }
}

@objc extension ConfirmMSGViewModel {
    func createNewPassword() {
        
        
    }
    
    func sendOtpAgain() {
        start()
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
