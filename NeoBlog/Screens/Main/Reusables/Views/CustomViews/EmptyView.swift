//
//  EmptyView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 08/03/24.
//

import UIKit

class EmptyView: BaseView {
    //MARK: Properties
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.setLineSpacing(lineHeightMultiple: 1.2)
        label.textAlignment = .center
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        return stack
    }()
    
    //MARK: Methods
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(vStack)
        vStack.addArrangedSubviews(titleLabel, descriptionLabel)
        
        vStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}


