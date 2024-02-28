//
//  TwoActionSheetNormal.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 27/02/24.
//

import UIKit
import PanModal

class TwoActionSheet: BaseView {
    //MARK: Methods
    private let titleLabel = makeTitleLabel()
    let firstBtn = makeButton()
    let secondBtn = makeButton()
    private let vStack = makeVStack()
    
    //MARK: Properties
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(titleLabel, vStack)
        vStack.addArrangedSubviews(firstBtn, secondBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        firstBtn.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
extension TwoActionSheet {
    static func makeTitleLabel() -> UILabel {
        let container = LabelsContainer()
        let label = container.makeLabel(text: "", size: .large2)
        return label
    }
    
    static func makeButton() -> UIButton {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        return button
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }
}
