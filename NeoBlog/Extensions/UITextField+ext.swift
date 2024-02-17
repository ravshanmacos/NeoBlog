//
//  UITextField+ext.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/02/24.
//

import UIKit

extension UITextField {
    func activeBorders() {
        layer.borderWidth = 1
        layer.borderColor = R.color.blue_color_1()?.cgColor
    }
    
    func inActiveBorders() {
        layer.borderWidth = 0
    }
    
    func errorBorders() {
        layer.borderWidth = 1
        layer.borderColor = R.color.red_color_1()?.cgColor
    }
}
