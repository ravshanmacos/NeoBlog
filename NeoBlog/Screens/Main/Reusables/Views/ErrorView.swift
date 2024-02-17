//
//  ErrorView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/02/24.
//

import UIKit

class ErrorView: BaseView {
    
    //MARK: Properties
    let icon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 18, weight: .regular)
        lbl.textColor = .white
        lbl.textAlignment = .left
        return lbl
    }()
    
    //MARK: Methods
    init(image: UIImage, subtitle: String, color: UIColor) {
        self.icon.image = image
        self.subtitleLabel.text = subtitle
        super.init(frame: .zero)
        self.contentView.backgroundColor = color
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(icon, subtitleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(28)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(12)
            make.centerY.equalTo(icon.snp.centerY)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 12
    }
}
