//
//  MainScreenRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

class MainScreenRootView: BaseView {
    
    //MARK: Properties
    private let headerView: HeaderView = {
       let header = HeaderView()
        
        return header
    }()
    
    private let viewModel: MainScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
}
