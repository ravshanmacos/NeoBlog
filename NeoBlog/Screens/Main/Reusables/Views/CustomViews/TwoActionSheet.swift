//
//  TwoActionSheetNormal.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 27/02/24.
//

import UIKit
import PanModal

class TwoActionSheet: BaseViewController {
    //MARK: Methods
    private let titleLabel = makeTitleLabel()
    private let firstBtn = makeFirstButton()
    private let secondBtn = makeSecondButton()
    private let vStack = makeVStack()
    
    //MARK: Properties
    override init() {
        super.init()
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubviews(titleLabel, vStack)
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
    
    func configure(title: String, 
                   firstBtnTitle: String,
                   firstBtnImg: UIImage?, 
                   secondBtnTitle: String,
                   secondBtnImg: UIImage?) 
    {
        self.titleLabel.text = title
        self.firstBtn.setTitle(firstBtnTitle, for: .normal)
        self.firstBtn.setImage(firstBtnImg, for: .normal)
        self.secondBtn.setTitle(secondBtnTitle, for: .normal)
        self.secondBtn.setImage(secondBtnImg, for: .normal)
    }
}
extension TwoActionSheet {
    static func makeTitleLabel() -> UILabel {
        let container = LabelsContainer()
        let label = container.makeLabel(text: "", size: .large2)
        return label
    }
    
    static func makeFirstButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        return button
    }
    
    static func makeSecondButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        return button
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }
}

extension TwoActionSheet: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(150)
    }
}
