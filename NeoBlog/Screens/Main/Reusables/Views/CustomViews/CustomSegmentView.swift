//
//  CustomSegmentView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 27/02/24.
//

import UIKit

enum CustomSegmentViewState {
    case myPostsActive, collectionsActive
}

protocol CustomSegmentViewDelegate: AnyObject {
    func myPostsTapped()
    func collectionsTapped()
}

class CustomSegmentView: BaseView {
    //MARK: Properties
    let myPostsBtn = makeButton(title: "Мои посты")
    let collectionsBtn = makeButton(title: "Подборки")
    
    private let myPostBottomLine = UIView()
    private let collectionsBottomLine = UIView()
    
    private let myPostsVStack = makeVStack()
    private let collectionsVStack = makeVStack()
    
    private let hStack = makeHStack()
    weak var delegate: CustomSegmentViewDelegate?
    
    //MARK: Methods
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(hStack)
        hStack.addArrangedSubviews(myPostsVStack, collectionsVStack)
        myPostsVStack.addArrangedSubviews(myPostsBtn, myPostBottomLine)
        collectionsVStack.addArrangedSubviews(collectionsBtn, collectionsBottomLine)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        hStack.snp.makeConstraints { $0.edges.equalToSuperview() }
        myPostBottomLine.snp.makeConstraints { $0.height.equalTo(1) }
        collectionsBottomLine.snp.makeConstraints { $0.height.equalTo(1) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        changeState(for: .myPostsActive)
        myPostsBtn.addTarget(self, action: #selector(myPostsTapped), for: .touchUpInside)
        collectionsBtn.addTarget(self, action: #selector(collectionsTapped), for: .touchUpInside)
    }
    @objc func myPostsTapped() {
        guard !myPostsBtn.isSelected else { return }
        changeState(for: .myPostsActive)
        delegate?.myPostsTapped()
    }
    
    @objc func collectionsTapped() {
        guard !collectionsBtn.isSelected else { return }
        changeState(for: .collectionsActive)
        delegate?.collectionsTapped()
    }
    
    
    private func changeState(for type: CustomSegmentViewState) {
        switch type {
        case .myPostsActive: activateMyPosts()
        case .collectionsActive: activateCollections()
        }
    }
    
    private func activateMyPosts() {
        myPostsBtn.isSelected = true
        myPostBottomLine.backgroundColor = R.color.blue_color_2()
        
        collectionsBtn.isSelected = false
        collectionsBottomLine.backgroundColor = .clear
    }
    
    private func activateCollections() {
        collectionsBtn.isSelected = true
        collectionsBottomLine.backgroundColor = R.color.blue_color_2()
        
        myPostsBtn.isSelected = false
        myPostBottomLine.backgroundColor = .clear
    }
}

extension CustomSegmentView {
    static func makeButton(title: String? = nil) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(R.color.blue_color_2(), for: .selected)
        button.setTitleColor(R.color.gray_color_2(), for: .normal)
        return button
    }
    
    static func makeHStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }
}
