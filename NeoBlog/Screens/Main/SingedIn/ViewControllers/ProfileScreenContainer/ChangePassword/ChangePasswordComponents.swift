//
//  CreateNewPasswordComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

extension ChangePasswordRootView {
    enum Strings: String {
        case headerTitle = "Создание пароля"
        case nextButtonTitle = "Сохранить"
        
        case newPasswordPlaceHolderTitle = "Новый пароль"
        case newPasswordAgainPlaceHolderTitle = "Новый пароль еще раз"
    }
    
    static func makeHeaderTitleLabel() -> UILabel {
        let container = LabelsContainer()
        return container.makeLabel(text: Strings.headerTitle.rawValue, size: .large)
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
