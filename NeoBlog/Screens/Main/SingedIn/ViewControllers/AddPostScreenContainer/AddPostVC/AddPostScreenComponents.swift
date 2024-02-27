//
//  AddPostScreenComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 27/02/24.
//

import UIKit

extension AddPostScreenRootView {
    
    static func categoryList() -> [CategoryItem] {
        let titles = ["Искусство", "IT", "Медицина", "Спорт", "Еда", "Животные", "Другое"]
        let items = titles.map { CategoryItem(title: $0) }
        items[0].active = true
        return items
    }
    
    //Labels
    static func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Новый пост"
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }
    
    static func makeCategoryLabel() -> UILabel {
        let label = UILabel()
        label.text = "Категория:"
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }
    
    static func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    //Inputfields
    static func makeHeadingTextfield() -> PrimaryTextfield {
        let textfield = PrimaryTextfield(fieldType: .normal(placeholder: "Заголовок"))
        return textfield
    }
    
    static func makeDescriptionTextview() -> UITextView {
        let textview = UITextView()
        textview.text = "Описание"
        textview.textColor = R.color.gray_color_2()
        textview.layer.cornerRadius = 10
        textview.backgroundColor = R.color.gray_color_3()
        textview.font = .systemFont(ofSize: 18, weight: .regular)
        textview.contentInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        return textview
    }
    
    //Buttons
    static func makeCloseViewButton() -> UIButton {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.setImage(R.image.close_icon(), for: .normal)
        return button
    }
    
    static func makePublisheButton() -> PrimaryButton {
        let button = PrimaryButton()
        button.setTitle("Опубликовать", for: .normal)
        return button
    }
    
    func makeCategoryButton() -> PrimaryButton2 {
        let button = PrimaryButton2()
        button.isUserInteractionEnabled = false
        return button
    }
    
    //Views
    static func makeUploadImageViewWrapper() -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.layer.cornerRadius = 10
        stack.backgroundColor = R.color.gray_color_3()
        return stack
    }
    
    //Stacks
    static func makeHeaderHStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }
}
