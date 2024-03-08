//
//  MainScreenRootViewComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import UIKit

extension MainScreenRootView {
    enum Strings: String {
        case commentsCount = "2"
        case postCategory = "Искусство"
        case titleLabel = "Три портрета Надежды Половцовой и не только"
        case subtitleLabel = "Просматривая портреты разных художников, невольно обращаешь внимание на тех, кто оставил след в истории. Каролюс-Дюран был одним из популярнейших французских салонных портретистов последней четверти XIX века. Его работы регулярно выставлялись в парижских Салонах; ему неоднократно присуждались награды. При создании портретов он талантливо умел сочетать достоверность с разумной долей идеализации при передаче облика портретируемых."
    }
    
    static func makeHeader() -> HeaderView {
        return HeaderView()
    }
    
    func makePostsTableView() -> UITableView {
        let tableview = UITableView()
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        PostsTableviewCell.register(to: tableview)
        return tableview
    }
    
    func makeEmptyView(subtitle: String? = nil) -> EmptyView {
        let emptyView = EmptyView()
        emptyView.titleLabel.text = "Еще нет постов"
        emptyView.descriptionLabel.text = subtitle ?? "Здесь будут показаны посты, добавленные в данную подборку"
        return emptyView
    }
}
