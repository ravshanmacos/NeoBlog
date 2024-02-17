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
    
    private let goToCreateNewPasswordNavigator: GoToCreateNewPasswordNavigator
    private var timer = Timer()
    
    //MARK: Methods
    init(goToCreateNewPasswordNavigator: GoToCreateNewPasswordNavigator) {
        self.goToCreateNewPasswordNavigator = goToCreateNewPasswordNavigator
    }
}

@objc extension ConfirmMSGViewModel {
    func createNewPassword() {
        goToCreateNewPasswordNavigator.navigateCreateNewPassword()
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
