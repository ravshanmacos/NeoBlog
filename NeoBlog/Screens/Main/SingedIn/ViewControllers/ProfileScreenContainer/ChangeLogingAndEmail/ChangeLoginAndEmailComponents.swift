//
//  CreateNewPasswordComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

extension ChangeLoginAndEmailRootView {
    enum Strings: String {
        case headerTitle = "Изменение логина и эл. почты"
        case nextButtonTitle = "Сохранить"
        
        case loginPlaceHolderTitle = "Логин"
        case emailPlaceHolderTitle = "Электронная почта"
    }
    
    static func makeHeaderTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = Strings.headerTitle.rawValue
        return label
    }
    
    static func makeLoginField() -> InputField {
        let field = PrimaryTextfield(fieldType: .username)
        field.placeholder = Strings.loginPlaceHolderTitle.rawValue
        return InputField(textfield: field)
    }
    
    static func makeEmailField() -> InputField {
        let field = PrimaryTextfield(fieldType: .confirmPassword)
        field.placeholder = Strings.emailPlaceHolderTitle.rawValue
        return InputField(textfield: field)
    }
    
    static func makeSaveBtn() -> PrimaryButton {
        let button = PrimaryButton()
         button.setTitle(Strings.nextButtonTitle.rawValue, for: .normal)
         return button
    }
    
    static func makeVStack() -> UIStackView {
        let container = StackContainer()
        return container.filledVStack()
    }
}
