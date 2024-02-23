//
//  HeaderView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

class HeaderView: BaseView {
    
    //MARK: Properties
    private let titleLabel = makeLabel()
    private let searchButton = makeSearchButton()
    
    private let cancelButton = makeCancelButton()
    let searchBarWithFilter = makeSearchBarWithFilter()
    private let hStack = makeStack()
    
    //MARK: Methods
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(hStack)
        //hStack.addArrangedSubviews(titleLabel, searchBarWithFilter, cancelButton)
        hStack.addArrangedSubviews(titleLabel, searchButton)
        
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints { $0.width.equalTo(self.contentWidth/8) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func searchButtonTapped() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn]) 
        {[weak self] in
            guard let self else { return }
            titleLabel.alpha = 0
            searchButton.alpha = 0
        } completion: {[weak self] _ in
            guard let self else { return }
            hStack.removeSubviews()
            titleLabel.alpha = 1
            searchButton.alpha = 1
            hStack.addArrangedSubviews(searchBarWithFilter, cancelButton)
            cancelButton.snp.remakeConstraints{ $0.width.equalTo(self.contentWidth * 1/5) }
        }
    }
    
    @objc private func cancelButtonTapped() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn])
        {[weak self] in
            guard let self else { return }
            searchBarWithFilter.alpha = 0
            cancelButton.alpha = 0
        } completion: {[weak self] _ in
            guard let self else { return }
            hStack.removeSubviews()
            searchBarWithFilter.alpha = 1
            cancelButton.alpha = 1
            hStack.addArrangedSubviews(titleLabel, searchButton)
            searchButton.snp.remakeConstraints { $0.width.equalTo(self.contentWidth/8) }
        }
    }
}

private extension HeaderView {
    static func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = "Главная"
        label.textColor = R.color.gray_color_1()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }
    
    static func makeCancelButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(R.color.gray_color_1(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }
    
    static func makeSearchButton() -> UIButton {
        let button = UIButton()
        let searchIcon = R.image.search_icon()
        button.setImage(searchIcon?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }
    
    static func makeSearchBarWithFilter() -> SearchBarWithFilter {
        let view = SearchBarWithFilter()
        view.setButton(icon: R.image.search_icon(), for: .left)
        view.setButton(icon: R.image.filter_icon(), for: .right)
        return view
    }
    
    static func makeStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }
}
