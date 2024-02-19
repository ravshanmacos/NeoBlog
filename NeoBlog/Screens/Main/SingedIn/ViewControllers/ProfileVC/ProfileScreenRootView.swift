//
//  ProfileScreenRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

class ProfileScreenRootView: BaseView {
    
    //MARK: Properties
    private let viewModel: ProfileScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: ProfileScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
}
