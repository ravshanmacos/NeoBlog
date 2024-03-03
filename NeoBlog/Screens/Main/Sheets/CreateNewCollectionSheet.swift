//
//  CreateNewCollectionSheet.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 25/02/24.
//

import Foundation
import PanModal

protocol CreateNewCollectionSheetDelegate: AnyObject {
    func collectionDidCreated(with name: String)
}

class CreateNewCollectionSheet: BaseViewController {
    
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let textfield = makeTextField()
    private let createBtn = makeCreateBtn()
    private let vStack = makeVStack()
    
    weak var delegate: CreateNewCollectionSheetDelegate?
    //MARK: Methods
    
    override init() {
        super.init()
        setKeyboardObservers()
        setupSubviews()
        configureAppearance()
    }
    
    func setKeyboardObservers() {
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupSubviews() {
        view.addSubviews(titleLabel, vStack)
        vStack.addArrangedSubviews(textfield, createBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        textfield.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    func configureAppearance() {
        textfield.delegate = self
        createBtn.addTarget(self, action: #selector(createBtnTapped), for: .touchUpInside)
    }
    
    //MARK: Actions
    
    @objc private func keyboardWillShow(notification: Notification) {
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .shortForm)
    }
    
    @objc private func createBtnTapped() {
        guard let text = textfield.text else { return }
        dismiss(animated: true)
        delegate?.collectionDidCreated(with: text)
    }
}

extension CreateNewCollectionSheet: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        if let text = textField.text, text.count > 1 {
            createBtn.isEnabled = true
        } else {
            createBtn.isEnabled = false
        }
        return true
    }
}

extension CreateNewCollectionSheet {
    static func makeTitleLabel() -> UILabel {
        let container = LabelsContainer()
        let label = container.makeLabel(text: "Новая подборка", size: .large2)
        return label
    }
    
    static func makeTextField() -> PrimaryTextfield {
        let textfield = PrimaryTextfield(fieldType: .username)
        return textfield
    }
    
    static func makeCreateBtn() -> PrimaryButton {
        let button = PrimaryButton()
        button.isEnabled = false
        button.setTitle("Создать", for: .normal)
        return button
    }
    
    static func makeVStack() -> UIStackView {
        let container = StackContainer()
        return container.filledEqualyVStack()
    }
}

extension CreateNewCollectionSheet: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight{
        return .contentHeight(180)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(500)
    }
}
