//
//  ButtonsContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

class ButtonsContainer {
    func noBckTitleRightButton(title: String?) -> UIButton {
        let button = noBckButton(title: title)
        button.contentHorizontalAlignment = .right
        return button
    }
    
    func noBckButton(title: String?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(R.color.blue_color_2(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }
}
