//
//  TextFieldErrorView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/02/24.
//

import UIKit
import Combine

extension TextFieldErrorView {
    enum TextFieldState {
        case normal
        case active(text: String)
        case error(text: String)
    }
}

class TextFieldErrorView: UIView {
    
    //MARK: Properties
    private let errorLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    //MARK: Methods
    init(frame: CGRect = .zero, text: String? = "") {
        self.errorLabel.text = text
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        addSubviews(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    func setTextFieldState(state: TextFieldState) {
        switch state {
        case .normal:
            errorLabel.text = ""
        case .active(let text):
            errorLabel.text = text
            errorLabel.textColor = R.color.gray_color_2()
        case .error(let text):
            errorLabel.text = text
            errorLabel.textColor = R.color.red_color_1()
        }
    }
}
