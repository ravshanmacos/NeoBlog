//
//  SignInRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import Combine
import SwiftEntryKit

class SignInRootView: BaseView {
    //MARK: Properties
    private let headerTitleLabel = makeHeaderTitleLabel()
    private let forgotPasswordButton = makeForgotPasswordBtn()
    private let signInButton = makeSignInBtn()
    private let vStack = makeVStack()
    
    private let emailInputField = InputField(textfield: .init(fieldType: .email))
    private let passwordInputField = InputField(textfield: .init(fieldType: .password))
    
    private let viewModel: SignInViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindTextFieldToViewModel()
        bindViewModelToView()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerTitleLabel, vStack)
        vStack.addArrangedSubviews(emailInputField, passwordInputField, forgotPasswordButton, signInButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(snp.centerY).multipliedBy(0.6)
        }
        vStack.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        emailInputField.textfield.text = "Roma9805"
        passwordInputField.textfield.text = "Ravshan9805"
        
        emailInputField.textfield.delegate = self
        passwordInputField.textfield.delegate = self
        
        forgotPasswordButton.addTarget(viewModel, action: #selector(viewModel.forgotPassword), for: .touchUpInside)
        signInButton.addTarget(viewModel, action: #selector(viewModel.signIn), for: .touchUpInside)
    }
}

extension SignInRootView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.activeBorders()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.inActiveBorders()
    }
}

//MARK: Textfield to ViewModel
private extension SignInRootView {
    func bindTextFieldToViewModel() {
        bindEmailToViewModel()
        bindPasswordToViewModel()
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
}

//MARK: ViewModel to Textfield

private extension SignInRootView {
    func bindViewModelToView() {
        bindEmailToEmailField()
        bindPasswordToPasswordField()
        bindSignInButtonToSignInButton()
        bindErrorsToViewModel()
    }
    
    func bindEmailToEmailField() {
        viewModel
            .$emailFieldEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: emailInputField.textfield)
            .store(in: &subscriptions)
    }
    
    func bindPasswordToPasswordField() {
        viewModel
            .$passwordFieldEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: passwordInputField.textfield)
            .store(in: &subscriptions)
    }
    
    func bindSignInButtonToSignInButton() {
        viewModel
            .$signInButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: signInButton)
            .store(in: &subscriptions)
    }
    
    func bindErrorsToViewModel() {
        viewModel
            .errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] text in
                self?.showAlert(subtitle: text)
                self?.emailInputField.setTextFieldState(state: .error(text: ""))
                self?.passwordInputField.setTextFieldState(state: .error(text: ""))
            }.store(in: &subscriptions)
    }
}
