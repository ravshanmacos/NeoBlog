//
//  SortByDateSheet.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 23/02/24.
//

import UIKit
import PanModal

class SortByDateSheet: BaseViewController {
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let vStack = makeVStack()
    private let optionData = optionData()
    
    //MARK: Methods
    override init() {
        super.init()
        setupSubviews()
        setupConstaints()
        configureAppearance()
    }
    
    @objc func radioButtonSelected(_ sender: UIButton) {
        unSelectAllRadioButtons()
        sender.isSelected = true
        print(sender.tag)
    }
}

//MARK: Setup UI
private extension SortByDateSheet {
    func setupSubviews() {
        view.addSubviews(titleLabel, vStack)
        optionData.enumerated().forEach { (index, optionString) in
            let optionView = makeOptionView(text: optionString)
            configureRadioButton(for: optionView, with: index)
            
            vStack.addArrangedSubview(optionView)
        }
    }
    
    func setupConstaints() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configureAppearance() {
        view.backgroundColor = .white
    }
    
    func configureRadioButton(for view: UIView, with tag: Int) {
        guard let radiobutton = view.subviews[0] as? UIButton else { return }
        if tag == 0 { radiobutton.isSelected = true }
        
        radiobutton.tag = tag
        radiobutton.addTarget(self, action: #selector(radioButtonSelected), for: .touchUpInside)
    }
    
    func unSelectAllRadioButtons() {
        vStack.subviews.forEach { optionView in
            guard let radiobutton = optionView.subviews[0] as? UIButton else { return }
            radiobutton.isSelected = false
        }
    }
}

//MARK: Configure Sheet
extension SortByDateSheet: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(350)
    }
}

private extension SortByDateSheet {
    static func makeTitleLabel() -> UILabel {
        let labelContainer = LabelsContainer()
        return labelContainer.makeLabel(text: "Сортировать по дате", size: .large2)
    }
    
    static func optionData() -> [String] {
        return ["За неделю", "За месяц", "За полгода", "Другое"]
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }
    
    //options
    func makeOptionView(text: String) -> UIView {
        let optionLabel = makeOptionLabel(with: text)
        let radioButton = makeRadioButton()
        let view = UIView()
        view.addSubviews(radioButton, optionLabel)
        radioButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.height.width.equalTo(40)
        }
        optionLabel.snp.makeConstraints {
            $0.leading.equalTo(radioButton.snp.trailing).offset(5)
            $0.centerY.equalTo(radioButton.snp.centerY)
        }
        return view
    }
    func makeOptionLabel(with text: String) -> UILabel {
        let labelContainer = LabelsContainer()
        return labelContainer.makeLabel(text: text, size: .medium2)
    }
    
    func makeRadioButton() -> UIButton {
        let radioButton = UIButton()
        radioButton.setImage(R.image.radioBtn_inactive_icon(), for: .normal)
        radioButton.setImage(R.image.radioBtn_active_icon(), for: .selected)
        return radioButton
    }
}
