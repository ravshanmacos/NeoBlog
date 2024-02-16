//
//  PrimaryTextfield.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/02/24.
//

import UIKit

extension PrimaryTextfield {
    enum PrimaryFieldType {
        case username
        case email
        case password
        case confirmPassword
    }
    
    enum PrimaryTextfieldState {
        case normal
        case editing
        case error
    }
}

class PrimaryTextfield: UITextField {
    
    //MARK: Properties
    
    let primaryFieldType: PrimaryFieldType
    
    //MARK: Methods
    init(frame: CGRect = .zero, fieldType: PrimaryFieldType) {
        self.primaryFieldType = fieldType
        super.init(frame: frame)
        configureAppearance()
        configureFieldType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/4
    }
    
    private func configureAppearance() {
        font = .systemFont(ofSize: 18, weight: .regular)
        backgroundColor = .secondarySystemBackground
        setLeftPaddingPoints(12)
    }
    
    func setPrimaryTextfieldState(state: PrimaryTextfieldState) {
        switch state {
        case .normal:
            print("Normal")
        case .editing:
            layer.borderWidth = 1
            layer.borderColor = R.color.blue_color_2()?.cgColor
        case .error:
            layer.borderWidth = 1
            layer.borderColor = R.color.red_color_1()?.cgColor
        }
    }
}

private extension PrimaryTextfield {
    func configureFieldType() {
        switch primaryFieldType {
        case .username: configureForUserName()
        case .email: configureForEmail()
        case .password, .confirmPassword: configureForPassword()
        }
    }
    
    func configureForUserName() {
        self.placeholder = "Логин"
    }
    
    func configureForEmail() {
        self.placeholder = "Электронная почта"
        self.keyboardType = .emailAddress
        self.textContentType = .emailAddress
    }
    
    func configureForPassword() {
        self.placeholder = "Пароль"
        self.textContentType = .oneTimeCode
        self.isSecureTextEntry = true
        self.enablePasswordToggle()
    }
}
