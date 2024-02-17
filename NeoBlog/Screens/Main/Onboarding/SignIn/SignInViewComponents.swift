//
//  File.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

extension SignInRootView {
    enum Strings: String {
        case headerTitle = "Вход"
        
        case forgotButtonTitle = "Забыли пароль?"
        case nextButtonTitle = "Войти"
    }
    
    static func makeHeaderTitleLabel() -> UILabel {
        let container = LabelsContainer()
        return container.makeLabel(text: Strings.headerTitle.rawValue, size: .large)
    }
    
    static func makeForgotPasswordBtn() -> UIButton {
        let container = ButtonsContainer()
        return container.noBckTitleRightButton(title: Strings.forgotButtonTitle.rawValue)
    }
    
    static func makeSignInBtn() -> PrimaryButton {
        let button = PrimaryButton()
         button.setTitle(Strings.nextButtonTitle.rawValue, for: .normal)
         return button
    }
    
    static func makeVStack() -> UIStackView {
        let container = StackContainer()
        return container.filledVStack()
    }
}
