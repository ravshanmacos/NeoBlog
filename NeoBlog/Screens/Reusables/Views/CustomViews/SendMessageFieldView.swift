//
//  SendMessageFieldView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 23/02/24.
//

import UIKit

protocol SendMessageFieldViewDelegate: AnyObject {
    func sendMessageTapped(message: String, textfield: UITextField)
}

class SendMessageFieldView: BaseView {
    
    //MARK: Properties
    private let messageTextfield = makeMessageTextfield()
    private let sendMessageButton = makeSendMessageButton()
    private let hStack = makeHStack()
    
    weak var delegate: SendMessageFieldViewDelegate?
    
    //MARK: Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        enableSendMsgBtn()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        messageTextfield.layer.cornerRadius = frame.height/4
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(hStack)
        hStack.addArrangedSubviews(messageTextfield, sendMessageButton)
        
        hStack.snp.makeConstraints { $0.edges.equalToSuperview() }
        sendMessageButton.snp.makeConstraints { $0.width.equalTo(32) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        messageTextfield.delegate = self
        sendMessageButton.addTarget(self, action: #selector(sendMessageTapped), for: .touchUpInside)
    }
    
    @objc private func sendMessageTapped() {
        guard let text = messageTextfield.text else { return }
        delegate?.sendMessageTapped(message: text, textfield: messageTextfield)
    }
    
    func enableSendMsgBtn() {
        sendMessageButton.isEnabled = true
        sendMessageButton.isUserInteractionEnabled = true
    }
    
    func disableSendMsgBtn() {
        sendMessageButton.isEnabled = false
        sendMessageButton.isUserInteractionEnabled = false
    }
}

extension SendMessageFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}

private extension SendMessageFieldView {
    static func makeMessageTextfield() -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = "Ваш комментарий"
        textfield.setLeftPaddingPoints(10)
        textfield.backgroundColor = R.color.gray_color_3()
        return textfield
    }
    
    static func makeSendMessageButton() -> UIButton {
        let button = UIButton()
        button.setImage(R.image.active_sendMsg_icon(), for: .normal)
        button.setImage(R.image.inActive_sendMsg_icon(), for: .disabled)
        return button
    }
    
    static func makeHStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.layer.cornerRadius = 12
        return stack
    }
}
