//
//  BottomPopUpWithTwoActions.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 28/02/24.
//

import UIKit

class BottomPopUpWithTwoActions: BaseView {
    //MARK: Properties
    let titleLabel = LabelsContainer().makeLabel(text: "", size: .large2)
    let firstBtn = PrimaryButton()
    let secondBtn = ButtonsContainer().noBckButton(title: nil)
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: Methods
    
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
            make.bottom.equalToSuperview()
        }
        
        firstBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
}
