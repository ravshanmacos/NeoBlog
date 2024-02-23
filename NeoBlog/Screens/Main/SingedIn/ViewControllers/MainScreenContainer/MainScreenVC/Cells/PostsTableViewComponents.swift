//
//  PostsTableViewComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import UIKit

extension PostsTableviewCell {
    //Titles
    static func makePostCategoryLabel() -> UILabel {
        let label = UILabel()
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }
    
    //CustomViews
    static func makePostImageView() -> UIImageView {
        let view = MainContainerViewComponents.makePostImageView(with: R.image.post_sample_image())
        return view
    }
    
    static func makeCommentsAndSaveView() -> UIStackView {
        let stack = MainContainerViewComponents.makeStack()
        let commentsBtn = makeIconButton(title: nil,
                                         icon: R.image.comment_icon(), selectedIcon: nil)
        let saveBtn = makeIconButton(icon: R.image.save_inactive_icon(), selectedIcon: R.image.save_active_icon())
        commentsBtn.titleEdgeInsets.left = -5
        commentsBtn.titleEdgeInsets.right = -5
        stack.addArrangedSubviews(commentsBtn, saveBtn)
        return stack
    }
    
    static func makeIconButton(title: String? = nil, icon: UIImage?, selectedIcon: UIImage?) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 8
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(R.color.gray_color_1(), for: .normal)
        
        button.setImage(icon, for: .normal)
        button.setImage(selectedIcon, for: .selected)
        
        //button
        button.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = R.color.gray_color_3()
        return button
    }
}

