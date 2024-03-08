//
//  ChangeLoginAndEmailRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit
import Combine

class ChangeLoginAndEmailRootView: ScrollableBaseView {
    
    //MARK: Properties
    private let vStack = makeVStack()
    private let saveButton = makeSaveBtn()
    private let headerTitleLabel = makeHeaderTitleLabel()
    private let loginField = makeLoginField()
    private let emailField = makeEmailField()
    
    private let viewModel: ChangeLoginAndEmailViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: ChangeLoginAndEmailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
        bindViewToViewModel()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        scrollViewContent.addSubviews(headerTitleLabel, vStack, saveButton)
        vStack.addArrangedSubviews(loginField, emailField)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        scrollViewContent.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(scrollView.snp.height)
        }
        
        headerTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        vStack.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        loginField.headerLabel.text = "Логин"
        emailField.headerLabel.text = "Электронная почта"
        
        loginField.textfield.delegate = self
        emailField.textfield.delegate = self
        
        saveButton.addTarget(viewModel, action: #selector(viewModel.save), for: .touchUpInside)
    }
}

extension ChangeLoginAndEmailRootView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginField.setTextFieldState(state: .normal)
        emailField.setTextFieldState(state: .normal)
        textField.activeBorders()
        if let textfield = textField as? PrimaryTextfield {
            switch textfield.primaryFieldType {
            case .username:
                loginField
                    .setTextFieldState(state: .active(text: Constants.Strings.usernameWarning))
            default:
                break
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.inActiveBorders()
    }
}

extension ChangeLoginAndEmailRootView {
    func bindViewModelToView() {
        bindPasswordToViewModel()
        bindConfirmPasswordToViewModel()
    }
    
    func bindPasswordToViewModel() {
        loginField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.login, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindConfirmPasswordToViewModel() {
        emailField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.email, on: viewModel)
            .store(in: &subscriptions)
    }
}

private extension ChangeLoginAndEmailRootView {
    func bindViewToViewModel() {
        viewModel
            .$authErrors
            .receive(on: DispatchQueue.main)
            .sink {[weak self] errorState in
                guard let self else { return }
                self.presentErrorState(state: errorState)
            }.store(in: &subscriptions)
        
        viewModel
            .successMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] message in
                guard let self else { return }
                self.showAlert(image: R.image.check_circle_icon()!,
                               color: R.color.green_color_1()!,
                               subtitle: message)
            }.store(in: &subscriptions)
    }
    
    private func presentErrorState(state: AuthErrors) {
        loginField.setTextFieldState(state: .normal)
        emailField.setTextFieldState(state: .normal)
        switch state {
        case .initial:
            print("Initial")
        case .InvalidUsername:
            loginField.setTextFieldState(state: .error(text: Constants.Strings.usernameWarning))
        case .InvalidEmail:
            emailField.setTextFieldState(state: .error(text: Constants.Strings.invalidEmail))
        default:
            break
        }
    }
}
