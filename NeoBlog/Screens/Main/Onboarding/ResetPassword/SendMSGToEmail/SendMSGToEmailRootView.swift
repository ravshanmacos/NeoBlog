//
//  SendMSGToEmailRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit
import Combine

class SendMSGToEmailRootView: BaseView, UITextFieldDelegate {
    
    //MARK: Properties
    private let vStack = makeVStack()
    private let nextButton = makeNextBtn()
    private let emailInputField = InputField(textfield: .init(fieldType: .email))
    private let headerTitleLabel = makeHeaderTitleLabel()
    private let headerSubtitleLabel = makeHeaderSubtitleLabel()
    
    private let viewModel: SendMSGToEmailViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: SendMSGToEmailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindings()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerTitleLabel, headerSubtitleLabel, vStack)
        vStack.addArrangedSubviews(emailInputField, nextButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(snp.centerY).multipliedBy(0.6)
        }
        
        headerSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(headerSubtitleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        emailInputField.textfield.delegate = self
        
        nextButton.addTarget(viewModel, action: #selector(viewModel.confirmMsg), for: .touchUpInside)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, text.count > 1 {
            viewModel.enableNextButton()
        } else {
            viewModel.disableNextButton()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.count < 0 {
            viewModel.disableNextButton()
        }
    }
}

private extension SendMSGToEmailRootView {
    func bindings() {
        bindEmailToViewModel()
        bindEmailToEmailField()
        bindNextButton()
        bindErrorsToViewModel()
    }
    
    func bindEmailToViewModel() {
        emailInputField
            .textfield
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.email, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindEmailToEmailField() {
        viewModel
            .$emailFieldEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: emailInputField.textfield)
            .store(in: &subscriptions)
    }
    
    func bindNextButton() {
        viewModel
            .$nextButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: nextButton)
            .store(in: &subscriptions)
    }
    
    func bindErrorsToViewModel() {
        viewModel
            .errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] text in
                self?.showAlert(subtitle: text)
            }.store(in: &subscriptions)
    }
}
