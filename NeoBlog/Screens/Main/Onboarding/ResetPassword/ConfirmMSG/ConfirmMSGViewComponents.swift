//
//  ConfirmMSGViewComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

//MARK: Components
extension ConfirmMSGRootView {
    
    enum Strings: String {
        case headerTitle = "Восстановление пароля"
        case headerSubtitle = "На почту example@gmail.com было выслано письмо с 4-значным кодом. Введите его ниже"
        case sendAgainTitle = "Отправить код повторно"
        case sendAgainAfterTitle = "Отправить код повторно через 00:"
        case buttonTitle = "Далее"
    }
    
    static func makeHeaderTitleLabel() -> UILabel {
        let container = LabelsContainer()
        return container.makeLabel(text: Strings.headerTitle.rawValue, size: .large)
    }
    
    static func makeHeaderSubtitleLabel() -> UILabel {
        let container = LabelsContainer()
        return container.makeLabel(text: Strings.headerSubtitle.rawValue, size: .medium)
    }
    
    static func makeButton() -> PrimaryButton {
        let button = PrimaryButton()
        button.setTitle(Strings.buttonTitle.rawValue, for: .normal)
        return button
    }
    
    static func makeFeatureButton(title: String = "") -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(R.color.blue_color_2(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        return stack
    }
}
