//
//  UIStackView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/02/24.
//

import UIKit

extension UIStackView {
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func insertArrangedSubview(_ view: UIView, belowArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0 + 1)
            }
        }
    }
    
    func insertArrangedSubview(_ view: UIView, aboveArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0)
            }
        }
    }
}
