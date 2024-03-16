//
//  InfoWithTwoSides.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 23/02/24.
//

import UIKit

class InfoWithTwoSides: BaseView {
    
    //MARK: Properties
    private let leftSideLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let rightSideLabel: LabelWithPadding = {
        let label = LabelWithPadding(withInsets: 5, 5, 10, 10)
        label.clipsToBounds = true
        label.textColor = R.color.gray_color_1()
        label.backgroundColor = R.color.gray_color_3()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let hStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    //MARK: Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        rightSideLabel.layer.cornerRadius =  rightSideLabel.intrinsicContentSize.height/2
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(hStack)
        hStack.addArrangedSubviews(leftSideLabel, rightSideLabel)
        
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
    
    func setRightSideLabel(text: String) {
        rightSideLabel.text = text
    }
    
    func setLeftSideLabel(text: String) {
        leftSideLabel.text = text
    }
}
