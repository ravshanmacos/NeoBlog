//
//  MainContainerViewComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import UIKit

class MainContainerViewComponents {
    //Labels
    static func makePostTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    static func makePostSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }
    
    static func makeHeaderLabel() -> UILabel {
        let label = UILabel()
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }
    
    //CustomViews
    static func makeProfileView() -> UIStackView {
        let stack = makeStack()
        let username = makeHeaderLabel()
        let profileIcon = makeImageView(with: R.image.profile_circle_icon())
        stack.addArrangedSubviews(profileIcon, username)
        return stack
    }
    
    static func makePostImageView(with image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }
    
    //Core Components
    static func makeStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }
    
    static func makeImageView(with image: UIImage?) -> UIImageView {
        let view = UIImageView()
        view.image = image
        view.contentMode = .scaleAspectFill
        return view
    }
}
