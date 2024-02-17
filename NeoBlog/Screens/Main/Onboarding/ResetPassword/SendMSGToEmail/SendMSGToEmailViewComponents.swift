//
//  SendMSGToEmailViewComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

extension SendMSGToEmailRootView {
    
    enum Strings: String {
        case headerTitle = "Восстановление пароля"
        case headerSubtitle = "Введите электронную почту, которую вы указывали в профиле"
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
    
    static func makeVStack() -> UIStackView {
        let container = StackContainer()
        return container.filledVStack()
    }
    
    static func makeNextBtn() -> PrimaryButton {
        let button = PrimaryButton()
         button.setTitle(Strings.buttonTitle.rawValue, for: .normal)
         return button
    }
    
}
