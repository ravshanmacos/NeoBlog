//
//  SignUpRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import Combine

class SignUpRootView: BaseView {
    
    //MARK: Properties
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = R.color.blue_color_1()
        return label
    }()
    
    private let signUpButton: PrimaryButton = {
       let button = PrimaryButton()
        button.isEnabled = true
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        return stack
    }()
    
    private let usernameInputField = InputField(textfield: .init(fieldType: .username))
    private let emailInputField = InputField(textfield: .init(fieldType: .email))
    private let passwordInputField = InputField(textfield: .init(fieldType: .password))
    private let confirmPasswordInputField = InputField(textfield: .init(fieldType: .confirmPassword))
    
    private let viewModel: SignUpViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        usernameInputField.textfield.delegate = self
        emailInputField.textfield.delegate = self
        passwordInputField.textfield.delegate = self
        confirmPasswordInputField.textfield.delegate = self
        
        bindTextFieldToViewModel()
        bindViewModelToView()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerTitleLabel, vStack)
        vStack.addArrangedSubviews(usernameInputField, emailInputField, passwordInputField, confirmPasswordInputField, signUpButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(snp.centerY).multipliedBy(0.5)
        }
        vStack.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
}

extension SignUpRootView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        usernameInputField.setTextFieldState(state: .normal)
        emailInputField.setTextFieldState(state: .normal)
        passwordInputField.setTextFieldState(state: .normal)
        confirmPasswordInputField.setTextFieldState(state: .normal)
        textField.activeBorders()
        if let textfield = textField as? PrimaryTextfield {
            switch textfield.primaryFieldType {
            case .username:
                usernameInputField.setTextFieldState(state: .active(text: Constants.String.usernameWarning))
            case .password:
                passwordInputField.setTextFieldState(state: .active(text: Constants.String.passwordWarning))
            case .confirmPassword:
                confirmPasswordInputField.setTextFieldState(state: .active(text: Constants.String.confirPasswordWarning))
            default:
                break
            }
        }
    }
}

@objc extension SignUpRootView {
    func signUpButtonTapped() {
        viewModel.signUp()
    }
}

private extension SignUpRootView {
    func bindTextFieldToViewModel() {
        bindUserNameToViewModel()
        bindEmailToViewModel()
        bindPasswordToViewModel()
        bindConfirmPasswordToViewModel()
    }
    
    func bindUserNameToViewModel() {
        usernameInputField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.username, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindEmailToViewModel() {
        emailInputField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.email, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindPasswordToViewModel() {
        passwordInputField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindConfirmPasswordToViewModel() {
        confirmPasswordInputField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.confirmPassword, on: viewModel)
            .store(in: &subscriptions)
    }
}

private extension SignUpRootView {
    func bindViewModelToView() {
        viewModel
            .$authErrors
            .receive(on: DispatchQueue.main)
            .sink {[weak self] errorState in
                guard let self else { return }
                self.presentErrorState(state: errorState)
            }.store(in: &subscriptions)
    }
    
    private func presentErrorState(state: AuthErrors) {
        usernameInputField.setTextFieldState(state: .normal)
        emailInputField.setTextFieldState(state: .normal)
        passwordInputField.setTextFieldState(state: .normal)
        confirmPasswordInputField.setTextFieldState(state: .normal)
        switch state {
        case .initial:
            print("Initial")
        case .InvalidUsername:
            usernameInputField.setTextFieldState(state: .error(text: Constants.String.usernameWarning))
        case .InvalidEmail:
            emailInputField.setTextFieldState(state: .error(text: Constants.String.invalidEmail))
        case .InvalidPassword:
            passwordInputField.setTextFieldState(state: .error(text: Constants.String.passwordWarning))
        case .InvalidConfirmPassword:
            confirmPasswordInputField.setTextFieldState(state: .error(text: Constants.String.invalidConfirmPassword))
        }
    }
}
