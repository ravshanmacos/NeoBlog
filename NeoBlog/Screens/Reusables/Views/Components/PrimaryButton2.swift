//
//  PrimaryButton2.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 26/02/24.
//

import UIKit

class PrimaryButton2: UIButton {
    
    //MARK: Properties
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                setTitleColor(.white, for: .normal)
                backgroundColor = R.color.blue_color_2()
            } else {
                setTitleColor(R.color.gray_color_1(), for: .normal)
                backgroundColor = R.color.gray_color_4()
            }
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
        titleEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: 5)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
    }
}
