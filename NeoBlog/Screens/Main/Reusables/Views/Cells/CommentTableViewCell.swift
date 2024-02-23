//
//  CommentTableViewCell.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 23/02/24.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    //MARK: Properties
    private let usernameLabel = makeUsernameLabel()
    private let dateLabel = makeDateLabel()
    private let descriptionLabel = makeDescriptionLabel()
    private let hStack = makeHStack()
    private let vStack = makeVStack()
    
    //MARK: Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubviews(vStack)
        vStack.addArrangedSubviews(hStack, descriptionLabel)
        hStack.addArrangedSubviews(usernameLabel, dateLabel, UIView())
        
        vStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setUsernameLabel(with text: String) {
        usernameLabel.text = text
    }
    
    func setDateLabel(with text: String) {
        dateLabel.text = text
    }
    
    func setDescriptionLabel(with text: String) {
        descriptionLabel.text = text
    }
}

private extension CommentTableViewCell {
    static func makeUsernameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }
    
    static func makeDateLabel() -> UILabel {
        let label = UILabel()
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }
    
    static func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }
    
    static func makeHStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }
}
