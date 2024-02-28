//
//  ChangeLoginAndEmailRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit
import Combine

class ChangeLoginAndEmailRootView: BaseView {
    
    //MARK: Properties
    private let vStack = makeVStack()
    private let saveButton = makeSaveBtn()
    private let headerTitleLabel = makeHeaderTitleLabel()
    private let newPasswordField = makeNewPasswordField()
    private let newPasswordFieldConfirm = makeNewPasswordAgainField()
    
    private let viewModel: ChangeLoginAndEmailViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: ChangeLoginAndEmailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        newPasswordField.textfield.delegate = self
        newPasswordFieldConfirm.textfield.delegate = self
        
        bindViewModelToView()
        bindViewToViewModel()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerTitleLabel, vStack)
        vStack.addArrangedSubviews(newPasswordField, newPasswordFieldConfirm, saveButton)
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
        
        saveButton.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        saveButton.addTarget(viewModel, action: #selector(viewModel.save), for: .touchUpInside)
    }
}

extension ChangeLoginAndEmailRootView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        newPasswordField.setTextFieldState(state: .normal)
        newPasswordFieldConfirm.setTextFieldState(state: .normal)
        textField.activeBorders()
        if let textfield = textField as? PrimaryTextfield {
            switch textfield.primaryFieldType {
            case .password:
                newPasswordField
                    .setTextFieldState(state: .active(text: Constants.Strings.passwordWarning))
            case .confirmPassword:
                newPasswordFieldConfirm
                    .setTextFieldState(state: .active(text: Constants.Strings.confirPasswordWarning))
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
        newPasswordField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindConfirmPasswordToViewModel() {
        newPasswordFieldConfirm
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.confirmPassword, on: viewModel)
            .store(in: &subscriptions)
    }
}

private extension ChangeLoginAndEmailRootView {
    func bindViewToViewModel() {
        bindAuthErrors()
        bindSuccessMessage()
    }
    
    func bindAuthErrors() {
        viewModel
            .$authErrors
            .receive(on: DispatchQueue.main)
            .sink {[weak self] errorState in
                guard let self else { return }
                self.presentErrorState(state: errorState)
            }.store(in: &subscriptions)
    }
    
    private func presentErrorState(state: AuthErrors) {
        newPasswordField.setTextFieldState(state: .normal)
        newPasswordFieldConfirm.setTextFieldState(state: .normal)
        switch state {
        case .initial:
            print("Initial")
        case .InvalidPassword:
            newPasswordField.setTextFieldState(state: .error(text: Constants.Strings.passwordWarning))
        case .InvalidConfirmPassword:
            newPasswordFieldConfirm.setTextFieldState(state: .error(text: Constants.Strings.invalidConfirmPassword))
        default:
            break
        }
    }
    
    func bindSuccessMessage() {
        viewModel
            .successMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] message in
                guard let self else { return }
                self.showAlert(image: R.image.check_circle_icon()!, color: R.color.green_color_1()!, subtitle: message)
            }.store(in: &subscriptions)
    }
}
