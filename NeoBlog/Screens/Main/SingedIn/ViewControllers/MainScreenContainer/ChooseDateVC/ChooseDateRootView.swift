//
//  ChooseDateRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 24/02/24.
//

import UIKit

class ChooseDateRootView: BaseView {
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let datePicker = makeDatePicker()
    let saveBtn = makeSaveButton()
    private let vStack = makeVStackView()
    
    private let periodType: PeriodType
    
    init(frame: CGRect = .zero, periodType: PeriodType) {
        self.periodType = periodType
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(vStack)
        vStack.addArrangedSubviews(titleLabel, datePicker, saveBtn)
        
        vStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        saveBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .black.withAlphaComponent(0.5)
        switch periodType {
        case .start: titleLabel.text = "С какого числа"
        case .end: titleLabel.text = "По какое число"
        }
    }
    
    func getCurrentDate() -> Date {
        return datePicker.date
    }
}

private extension ChooseDateRootView {
    static func makeTitleLabel() -> UILabel {
        let container = LabelsContainer()
        return container.makeLabel(text: "", size: .large2)
    }
    
    static func makeDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }
    
    static func makeSaveButton() -> PrimaryButton {
        let button = PrimaryButton()
        button.setTitle("Сохранить", for: .normal)
        return button
    }
    
    static func makeVStackView() -> UIStackView {
        let container = StackContainer()
        let stack = container.filledVStack()
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }
}
