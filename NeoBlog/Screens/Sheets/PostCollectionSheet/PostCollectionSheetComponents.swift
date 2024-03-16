//
//  PostCollectionSheetComponents.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 25/02/24.
//

import UIKit

struct OptionModel {
    let title: String
    var saveds = 0
    var isActive = false
    
    func getSavedDescriptions() -> String {
        return "Сохранено: \(saveds)"
    }
}

extension PostCollectionRootView {
    //Header
    static func makeTitleLabel() -> UILabel {
        let container = LabelsContainer()
        let label = container.makeLabel(text: "Подборки", size: .large2)
        label.textAlignment = .left
        return label
    }
    
    static func makeAddCollectionButton() -> UIButton {
        let container = ButtonsContainer()
        let button = container.noBckTitleRightButton(title: "+ Новая подборка")
        return button
    }
    
    static func makeHStack() -> UIStackView {
        let container = StackContainer()
        return container.filledEqualyHStack()
    }
    
    static func makeTableView() -> UITableView {
        let tableview = UITableView()
        tableview.rowHeight = 60
        tableview.separatorStyle = .none
        OptionViewTableViewCell.register(to: tableview)
        return tableview
    }
}
