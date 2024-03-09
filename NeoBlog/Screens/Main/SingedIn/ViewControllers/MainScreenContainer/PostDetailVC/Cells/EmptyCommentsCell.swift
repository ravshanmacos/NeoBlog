//
//  EmptyCommentsCell.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 23/02/24.
//

import UIKit

class EmptyCommentsCell: UITableViewCell {
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let descriptionLabel = makeDescriptionLabel()
    private let vStack = makeVStack()
    
    //MARK: Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubviews(vStack)
        vStack.addArrangedSubviews(titleLabel, descriptionLabel)
        vStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.7)
        }
    }
}

private extension EmptyCommentsCell {
    static func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Комментариев еще нет"
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }
    
    static func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.text = "Будьте первым, кто прокомментирует"
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }
}
