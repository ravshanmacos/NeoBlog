//
//  ProfileScreenComponenets.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 27/02/24.
//

import UIKit

extension ProfileScreenRootView {
    
    static func makeTitleLabel() -> UILabel {
        let label = AddPostScreenRootView.makeTitleLabel()
        label.text = "Профиль"
        return label
    }
    
    static func makeUsernameLabel() -> UILabel {
        let container = LabelsContainer()
        let label = container.makeLabel(text: "", size: .large)
        label.textAlignment = .left
        return label
    }
    
    static func makeMenuButton() -> UIButton {
        let button = UIButton()
        button.setImage(R.image.hambureger_menu_icon(), for: .normal)
        return button
    }
    
    func makeAddCollectionButton() -> UIButton {
        let container = ButtonsContainer()
        let button = container.noBckTitleRightButton(title: "+ Новая подборка")
        button.contentHorizontalAlignment = .left
        return button
    }
    
    static func makeCustomSegmentedView() -> CustomSegmentView {
        let view = CustomSegmentView()
        return view
    }
    
    static func makeHeaderHStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }
    
    func makePostsTableView() -> UITableView {
        let tableView = MainScreenRootView.makePostsTableView()
        return tableView
    }
    
    func makeCollectionTableView() -> UITableView {
        let tableview = UITableView(frame: .zero, style: .insetGrouped)
        tableview.rowHeight = 60
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.subviews.forEach { view in
            view.layer.shadowColor = UIColor.darkGray.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = 5
        }
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "CollectionCell")
        return tableview
    }
}
