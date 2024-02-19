//
//  SearchBarWithFilter.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

extension SearchBarWithFilter {
    enum Sides {
        case left, right
    }
}

class SearchBarWithFilter: BaseView {
    //MARK: Properties
    private let leftButton = makeButton()
    private let rightButton = makeButton()
    let searchTextField = makeTextfield()
    
    var leftButtonClicked: (() -> Void)?
    var rightButtonClicked: (() -> Void)?
    
    //MARK: Methods
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(searchTextField)
        searchTextField.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .always
        
        searchTextField.leftView = leftButton
        searchTextField.rightView = rightButton
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    func setButton(icon image: UIImage?, for side: Sides) {
        switch side {
        case .left: leftButton.setImage(image, for: .normal)
        case .right: rightButton.setImage(image, for: .normal)
        }
    }
}

//MARK: Actions
@objc private extension SearchBarWithFilter {
    func leftButtonTapped() {
        leftButtonClicked?()
    }
    
    func rightButtonTapped() {
        rightButtonClicked?()
    }
}

//MARK: Components
private extension SearchBarWithFilter {
    static func makeButton() -> UIButton {
        let button = UIButton()
        button.alpha = 0.5
        return button
    }
    
    static func makeTextfield() -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = "Поиск"
        textfield.backgroundColor = R.color.gray_color_3()
        textfield.layer.cornerRadius = 20
        return textfield
    }
}
