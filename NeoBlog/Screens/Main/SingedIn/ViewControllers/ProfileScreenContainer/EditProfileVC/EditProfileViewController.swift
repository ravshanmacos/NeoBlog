//
//  EditProfileViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 28/02/24.
//

import UIKit

protocol EditProfileViewModelFactory {
    func makeEditProfileViewModel() -> EditProfileViewModel
}

class EditProfileViewController: BaseViewController {
    //MARK: Properties
    private let factory: EditProfileViewModelFactory
    private let viewModel: EditProfileViewModel
    
    //MARK: Methods
    init(factory: EditProfileViewModelFactory) {
        self.factory = factory
        self.viewModel = factory.makeEditProfileViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = EditProfileRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitle(text: "Редактирование профиля")
    }
}
