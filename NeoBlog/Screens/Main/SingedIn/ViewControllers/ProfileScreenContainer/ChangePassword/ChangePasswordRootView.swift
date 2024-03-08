//
//  ChangePasswordRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit
import Combine

class ChangePasswordRootView: BaseView {
    
    //MARK: Properties
    private let vStack = makeVStack()
    private let saveButton = makeSaveBtn()
    private let headerTitleLabel = makeHeaderTitleLabel()
    
    private let currentPasswordField = makeCurrentPasswordField()
    private let newPasswordField = makeNewPasswordField()
    private let newPasswordFieldConfirm = makeNewPasswordAgainField()
    
    private let viewModel: ChangePasswordViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: ChangePasswordViewModel) {
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
        vStack.addArrangedSubviews(currentPasswordField, newPasswordField, newPasswordFieldConfirm, saveButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(40)
        }
        vStack.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        currentPasswordField.textfield.text = "Ravshanbek9805#"
        newPasswordField.textfield.text = "Ravshanbek9805@"
        newPasswordFieldConfirm.textfield.text = "Ravshanbek9805@"
        
        saveButton.addTarget(viewModel, action: #selector(viewModel.save), for: .touchUpInside)
    }
}

extension ChangePasswordRootView: UITextFieldDelegate {
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
            case .currentPassword:
                currentPasswordField
                    .setTextFieldState(state: .active(text: ""))
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

extension ChangePasswordRootView {
    func bindViewModelToView() {
        currentPasswordField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.currentPassword, on: viewModel)
            .store(in: &subscriptions)
        
        newPasswordField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
        
        newPasswordFieldConfirm
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.confirmPassword, on: viewModel)
            .store(in: &subscriptions)
    }
}

private extension ChangePasswordRootView {
    func bindViewToViewModel() {
        viewModel
            .$saveBtnEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &subscriptions)
        
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
                self.showAlert(image: R.image.check_circle_icon()!, color: R.color.green_color_1()!, subtitle: message)
            }.store(in: &subscriptions)
    }
    
    func presentErrorState(state: AuthErrors) {
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
}
