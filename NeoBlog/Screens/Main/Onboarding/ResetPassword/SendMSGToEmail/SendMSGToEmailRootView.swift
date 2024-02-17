//
//  SendMSGToEmailRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit
import Combine

class SendMSGToEmailRootView: BaseView {
    
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
        //emailInputField.textfield.delegate = self
        
        nextButton.addTarget(viewModel, action: #selector(viewModel.confirmMsg), for: .touchUpInside)
    }
}
