//
//  SecondaryButton.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

class SecondaryButton: UIButton {
    
    //MARK: Properties
    
    
    //MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        layer.borderColor = R.color.blue_color_2()?.cgColor
        layer.cornerRadius = frame.height/4
    }
    
    private func configureAppearance() {
        backgroundColor = .white
        setTitleColor(R.color.blue_color_1(), for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
    }
}
