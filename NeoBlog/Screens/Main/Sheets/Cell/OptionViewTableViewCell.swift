//
//  OptionViewTableViewCell.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 25/02/24.
//

import UIKit

class OptionViewTableViewCell: UITableViewCell {
    //MARK: Properties
    let titleLabel = makeTitleLabel()
    let descriptionLabel = makeDescriptionLabel()
    let radioButton = makeRadioButton()
    private let vStack = makeVStack()
    
    //MARK: Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubviews(radioButton, vStack)
        vStack.addArrangedSubviews(titleLabel, descriptionLabel)
    }
    
    func setupConstraints() {
        radioButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview()
        }
        
        vStack.snp.makeConstraints {
            $0.leading.equalTo(radioButton.snp.trailing).offset(5)
            $0.centerY.equalTo(radioButton.snp.centerY)
        }
    }
}

private extension OptionViewTableViewCell {
    
    //Components
    static func makeTitleLabel(with text: String = "") -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }
    
    static func makeDescriptionLabel(with text: String = "") -> UILabel {
        let labelContainer = LabelsContainer()
        let label = labelContainer.makeLabel(text: text, size: .small)
        label.textAlignment = .left
        return label
    }
    
    static func makeRadioButton() -> UIButton {
        let radioButton = UIButton()
        radioButton.setImage(R.image.radioBtn_inactive_icon(), for: .normal)
        radioButton.setImage(R.image.radioBtn_active_icon(), for: .selected)
        return radioButton
    }
    
    //Stacks
    static func makeVStack() -> UIStackView {
        let container = StackContainer()
        return container.filledVStack(spacing: 5)
    }
}
