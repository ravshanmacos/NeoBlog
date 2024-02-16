//
//  InputField.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/02/24.
//

import UIKit

extension InputField {
    enum InputFieldState {
        case normal
        case active(text: String)
        case error(text: String)
    }
}

class InputField: UIView {
    
    //MARK: Properties
    let textfield: PrimaryTextfield
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    private let descriptionLabel: LabelWithPadding = {
        let label = LabelWithPadding(withInsets: 0, 0, 10, 10)
        label.numberOfLines = 0
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    //MARK: Methods
    init(frame: CGRect = .zero, textfield: PrimaryTextfield) {
        self.textfield = textfield
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        addSubviews(vStack)
        vStack.addArrangedSubviews(textfield, descriptionLabel)
        
        vStack.snp.makeConstraints{ $0.edges.equalToSuperview() }
        textfield.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    func setTextFieldState(state: InputFieldState) {
        switch state {
        case .normal:
            descriptionLabel.text = ""
        case .active(let text):
            descriptionLabel.text = text
            descriptionLabel.textColor = R.color.gray_color_2()
        case .error(let text):
            descriptionLabel.text = text
            descriptionLabel.textColor = R.color.red_color_1()
            textfield.errorBorders()
        }
    }
}
