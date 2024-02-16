//
//  LaunchRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

class LaunchRootView: BaseView {
    //MARK: Properties
    private let viewModel: LaunchViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        loadUserSession()
    }
    
    private func loadUserSession() {
        viewModel.loadUserSession()
    }
}
