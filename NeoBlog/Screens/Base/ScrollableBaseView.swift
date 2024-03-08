//
//  ScrollableBaseView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 22/02/24.
//

import UIKit

class ScrollableBaseView: BaseView {
    
    //MARK: Properties
    let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    let scrollViewContent: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    //MARK: Methods
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(scrollView)
        scrollView.addSubviews(scrollViewContent)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollViewContent.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
    }
}
