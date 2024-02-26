//
//  UploadImageView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 26/02/24.
//

import UIKit

class UploadImageView: BaseView {
    //MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузить фотографию"
        label.textAlignment = .center
        label.textColor = R.color.blue_color_2()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: R.image.upload_image_icon())
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.backgroundColor =  R.color.gray_color_3()
        return stack
    }()
    
    //MARK: Methods
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(vStack)
        vStack.addArrangedSubviews(imageView, titleLabel)
        vStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        layer.cornerRadius = 10
        backgroundColor = R.color.gray_color_3()
    }
}
