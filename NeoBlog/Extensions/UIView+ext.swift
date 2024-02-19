//
//  UIView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import SwiftEntryKit

extension UIView {
    var contentWidth: CGFloat {
        return UIScreen.main.bounds.width - 30
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    //Alerts
    func showAlert(image: UIImage = R.image.errorCircle()!, color: UIColor = R.color.red_color_1()!, subtitle:String) {
        let errorView = ErrorView(image: image, subtitle: subtitle, color: color)
        var attributes = EKAttributes.topFloat
        attributes.displayDuration = 2.5
        attributes.windowLevel = .normal
        attributes.entryBackground =  .clear
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        attributes.positionConstraints.verticalOffset = 20
        attributes.positionConstraints.size.width = .offset(value: 0)
        attributes.entranceAnimation = .init(
            translate: .init( duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
            scale: .init( from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)
                        )
        )
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        SwiftEntryKit.display(entry: errorView, using: attributes)
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
