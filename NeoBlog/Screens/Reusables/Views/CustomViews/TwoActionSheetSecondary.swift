//
//  TwoActionSheetSecondary.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 08/03/24.
//

import UIKit
import PanModal

class TwoActionSheetSecondary: BaseView {
    
    //MARK: Methods
    private let headerVStack = makeHeaderVStack()
    private let btnsVStack = makeBtnsVStack()
    
    let titleLabel = makeTitleLabel()
    let descriptionLabel = makeDescriptionLabel()
    let firstActionBtn = makeFirstActionBtn()
    let secondActionBtn = makeSecondActionBtn()
    
    //MARK: Properties
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerVStack, btnsVStack)
        headerVStack.addArrangedSubviews(titleLabel, descriptionLabel)
        btnsVStack.addArrangedSubviews(firstActionBtn, secondActionBtn)
        
        headerVStack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        btnsVStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        firstActionBtn.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
}
extension TwoActionSheetSecondary {
    static func makeTitleLabel() -> UILabel {
        let container = LabelsContainer()
        let label = container.makeLabel(text: "", size: .large2)
        return label
    }
    
    static func makeDescriptionLabel() -> UILabel {
        let container = LabelsContainer()
        let label = container.makeLabel(text: "", size: .medium2)
        return label
    }
    
    static func makeFirstActionBtn() -> UIButton {
        let button = makeBtn()
        button.setTitleColor(R.color.gray_color_1(), for: .normal)
        return button
    }
    
    static func makeSecondActionBtn() -> UIButton {
        let button = makeBtn()
        button.setTitleColor(R.color.red_color_1(), for: .normal)
        return button
    }
    
    static func makeBtn() -> UIButton {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        return button
    }
    
    static func makeHeaderVStack() -> UIStackView {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }
    
    static func makeBtnsVStack() -> UIStackView {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }
}

