//
//  OTPView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit
import VKPinCodeView

class OTPView: BaseView {
    
    //MARK: Properties
    let pinView = makeVKPinCodeView()
    private let errorLabel = makeLabel()
    private let vStack = makeVStack()
    
    //MARK: Methods
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(vStack)
        vStack.addArrangedSubviews(pinView, errorLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack.snp.makeConstraints { $0.edges.equalToSuperview() }
        pinView.snp.makeConstraints { $0.height.equalTo(60) }
    }
    
    func enableErrorMode() {
        errorLabel.text = Strings.errorTitle.rawValue
    }
    
    func disableErrorMode() {
        errorLabel.text = nil
    }
}

extension OTPView {
    enum Strings: String {
        case errorTitle = "Неверный код"
    }
    
    static func makeVKPinCodeView() -> VKPinCodeView {
        let pinView = VKPinCodeView()
        pinView.resetAfterError = .afterError(TimeInterval(0.3))
        pinView.onSettingStyle = { BorderStyle() }
        pinView.becomeFirstResponder()
        return pinView
    }
    
    static func makeLabel(text: String = "") -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = R.color.red_color_1()
        return label
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        return stack
    }
}
