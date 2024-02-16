//
//  PrimaryButton.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

class PrimaryButton: UIButton {
    
    //MARK: Properties
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? R.color.blue_color_2() : R.color.blue_color_3()
        }
    }
    
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
        layer.cornerRadius = frame.height/4
    }
    
    private func configureAppearance() {
        isEnabled = true
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
    }
}
