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
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: R.image.upload_image_icon())
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    let uploadButton = UIButton()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    //MARK: Methods
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubviews(vStack, uploadButton)
        vStack.addArrangedSubviews(imageView, titleLabel)
        
        vStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
}

class UploadedImageView: BaseView {
    
    //MARK: Properties
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(R.image.close_icon(), for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: Methods
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(imageView, closeButton)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.width.equalTo(30)
        }
    }
}
