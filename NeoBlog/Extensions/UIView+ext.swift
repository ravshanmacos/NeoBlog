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
    
    /**
     Magically computes and sets an ideal corner radius.
     */
    func magicallySetCornerRadius() {
        layer.cornerRadius = 0.188 * min(frame.width, frame.height)
        layer.masksToBounds = true
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
    
    func showTwoActionPopUp(title: String?, firstBtnTitle: String?, secondBtnTittle: String?, firstBtnAction: UIAction, secondBtnAction: UIAction ) {
        let popUp = BottomPopUpWithTwoActions()
        popUp.titleLabel.text = title
        popUp.firstBtn.backgroundColor = R.color.red_color_1()
        popUp.firstBtn.setTitle(firstBtnTitle, for: .normal)
        popUp.secondBtn.setTitle(secondBtnTittle, for: .normal)
        popUp.firstBtn.addAction(firstBtnAction, for: .touchUpInside)
        popUp.secondBtn.addAction(secondBtnAction, for: .touchUpInside)

        // Attributes struct that describes the display, style, user interaction and animations of customView.
        var attributes = EKAttributes.bottomToast
        attributes.screenBackground = .color(color: .black.with(alpha: 0.5))
        attributes.positionConstraints.size = .intrinsic
        attributes.roundCorners = .all(radius: 10)
        attributes.displayDuration = .infinity
        attributes.windowLevel = .normal
        attributes.entryBackground =  .color(color: .white)
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        attributes.positionConstraints.verticalOffset = 40
        attributes.positionConstraints.size.width = .offset(value: 15)
        
        SwiftEntryKit.display(entry: popUp, using: attributes)
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
