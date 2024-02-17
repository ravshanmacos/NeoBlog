//
//  ConfirmMSGRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit
import VKPinCodeView
import Combine

class ConfirmMSGRootView: BaseView {
    
    //MARK: Properties
    private let otpView = OTPView()
    private let vStack = makeVStack()
    
    private let headerTitleLabel = makeHeaderTitleLabel()
    private let headerSubtitleLabel = makeHeaderSubtitleLabel()
    
    private let nextButton = makeButton()
    private let sendAgainOtpButton = makeFeatureButton(title: Strings.sendAgainTitle.rawValue)
    
    private let viewModel: ConfirmMSGViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: ConfirmMSGViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewToViewModel()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerTitleLabel, headerSubtitleLabel, vStack)
        vStack.addArrangedSubviews(otpView, sendAgainOtpButton, nextButton)
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
        otpView.pinView.onComplete = {[weak self] (code, pinView) in
            guard let self else { return }
            if code == "1234" {
                pinView.isError = true
                otpView.enableErrorMode()
                nextButton.isEnabled = false
            } else {
                pinView.isError = false
                otpView.disableErrorMode()
                nextButton.isEnabled = true
            }
        }
        
        sendAgainOtpButton.addTarget(viewModel, action: #selector(viewModel.sendOtpAgain), for: .touchUpInside)
        nextButton.addTarget(viewModel, action: #selector(viewModel.createNewPassword), for: .touchUpInside)
    }
}

//MARK: Bind View To View Model
private extension ConfirmMSGRootView {
    func bindViewToViewModel() {
        bindSendAgainOtpButtonToTimer()
        toggleSendAgainOtpButtonState()
    }
    
    func bindSendAgainOtpButtonToTimer() {
        viewModel
            .$seconds
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] second in
                guard let self else { return }
                let buttonTitle = Strings.sendAgainAfterTitle.rawValue + "\(second)"
                sendAgainOtpButton.setTitle(buttonTitle, for: .normal)
            }.store(in: &subscriptions)
    }
    
    func toggleSendAgainOtpButtonState() {
        viewModel
            .$sendOtpEnabled
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isEnabled in
                guard let self else { return }
                sendAgainOtpButton.isEnabled = isEnabled
                if isEnabled {
                    sendAgainOtpButton.setTitle(Strings.sendAgainTitle.rawValue, for: .normal)
                    sendAgainOtpButton.setTitleColor(R.color.blue_color_2(), for: .normal)
                } else {
                    let buttonTitle = Strings.sendAgainAfterTitle.rawValue + "\(viewModel.seconds)"
                    sendAgainOtpButton.setTitle(buttonTitle, for: .normal)
                    sendAgainOtpButton.setTitleColor(R.color.gray_color_2(), for: .normal)
                }
            }.store(in: &subscriptions)
    }
}


