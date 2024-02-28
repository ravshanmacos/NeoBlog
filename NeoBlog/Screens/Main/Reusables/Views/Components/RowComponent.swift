//
//  RowComponent.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 28/02/24.
//

import UIKit

class RowComponent: BaseView {
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let leftIconView = makeIconView()
    private let rightIconView = makeIconView()
    let button = UIButton()
    
    //MARK: Methods
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(leftIconView, titleLabel, rightIconView, button)
        
        leftIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftIconView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        rightIconView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        layer.cornerRadius = 10
        layer.borderColor = R.color.gray_color_2()?.cgColor
        layer.borderWidth = 0.5
    }
    
    func configure(title: String?, leftIcon: UIImage?, rightIcon: UIImage?) {
        titleLabel.text = title
        leftIconView.image = leftIcon
        rightIconView.image = rightIcon
    }
    
}

extension RowComponent {
    //Components
    static func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.isUserInteractionEnabled = false
        return label
    }
    
    static func makeIconView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        return imageView
    }
}
