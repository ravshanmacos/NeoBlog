//
//  TitlesCategoryCollectionViewCell.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 21/02/24.
//

import UIKit

class TitlesCategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let hStack = makeStack()
    
    //MARK: Properties
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hStack.layer.cornerRadius = frame.height / 2
    }
    
    private func setupSubviews() {
        addSubviews(hStack)
        hStack.addArrangedSubviews(titleLabel)
        hStack.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
    
    func activateCell() {
        titleLabel.textColor = .white
        hStack.backgroundColor = R.color.blue_color_2()
    }
    
    func disableCell() {
        titleLabel.textColor = R.color.gray_color_1()
        hStack.backgroundColor = .clear
    }
}

private extension TitlesCategoryCollectionViewCell {
    static func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }
    
    static func makeStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 5, left: 8, bottom: 5, right: 8)
        return stack
    }
}
