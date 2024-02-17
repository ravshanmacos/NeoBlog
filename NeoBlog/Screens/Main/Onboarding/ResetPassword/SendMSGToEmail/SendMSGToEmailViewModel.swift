//
//  SendMSGToEmail.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import Foundation

class SendMSGToEmailViewModel {
    
    //MARK: Properties
    private let goToConfirmMsgNavigator: GoToConfirmMSGNavigator
    
    //MARK: Methods
    init(goToConfirmMsgNavigator: GoToConfirmMSGNavigator) {
        self.goToConfirmMsgNavigator = goToConfirmMsgNavigator
    }
}

@objc extension SendMSGToEmailViewModel {
    func confirmMsg() {
        goToConfirmMsgNavigator.navigateConfirmMsgNavigator()
    }
}


