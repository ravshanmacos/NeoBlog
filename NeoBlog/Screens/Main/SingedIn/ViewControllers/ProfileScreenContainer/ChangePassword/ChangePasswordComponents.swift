//
//  CreateNewPasswordComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

extension ChangePasswordRootView {
    enum Strings: String {
        case headerTitle = "Изменение пароля"
        case nextButtonTitle = "Сохранить"
        
        case currentPasswordPlaceHolderTitle = "Текущий пароль"
        case newPasswordPlaceHolderTitle = "Новый пароль"
        case newPasswordAgainPlaceHolderTitle = "Новый пароль еще раз"
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
    
    static func makeCurrentPasswordField() -> InputField {
        let field = PrimaryTextfield(fieldType: .currentPassword)
        field.placeholder = Strings.currentPasswordPlaceHolderTitle.rawValue
        return InputField(textfield: field)
    }
    
    static func makeNewPasswordField() -> InputField {
        let field = PrimaryTextfield(fieldType: .password)
        field.placeholder = Strings.newPasswordPlaceHolderTitle.rawValue
        return InputField(textfield: field)
    }
    
    static func makeNewPasswordAgainField() -> InputField {
        let field = PrimaryTextfield(fieldType: .confirmPassword)
        field.placeholder = Strings.newPasswordAgainPlaceHolderTitle.rawValue
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
