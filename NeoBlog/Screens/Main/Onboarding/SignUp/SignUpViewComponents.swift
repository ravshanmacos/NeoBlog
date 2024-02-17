//
//  SignUpViewComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

extension SignUpRootView {
    enum Strings: String {
        case headerTitle = "Регистрация"
        case signUpTitle = "Зарегистрироваться"
    }
    
    static func makeHeaderTitleLabel() -> UILabel {
        let container = LabelsContainer()
        return container.makeLabel(text: Strings.headerTitle.rawValue, size: .large)
    }
    
    static func makeSignUpBtn() -> PrimaryButton {
        let button = PrimaryButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }
    
    static func makeVStack() -> UIStackView {
        let container = StackContainer()
        return container.filledVStack()
    }
}
