//
//  SignInRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import Combine

class SignInRootView: BaseView {
    //MARK: Properties
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = R.color.blue_color_1()
        return label
    }()
    
    private let forgotPasswordButton: UIButton = {
       let button = UIButton()
        button.contentHorizontalAlignment = .right
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(R.color.blue_color_2(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    private let signInButton: PrimaryButton = {
       let button = PrimaryButton()
        button.setTitle("Войти", for: .normal)
        return button
    }()
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        return stack
    }()
    
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
}
