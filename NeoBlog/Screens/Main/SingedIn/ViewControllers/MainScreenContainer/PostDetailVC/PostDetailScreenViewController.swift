//
//  PostDetailScreenViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

protocol PostDetailScreenViewModelFactory {
    func makePostDetailScreenViewModel() -> PostDetailScreenViewModel
}

class PostDetailScreenViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: PostDetailScreenViewModelFactory
    private let viewModel: PostDetailScreenViewModel
    
    //MARK: Methods
    
    init(postID: Int?, authorID: Int?, viewModelFactory: PostDetailScreenViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makePostDetailScreenViewModel()
        self.viewModel.postID = postID
        self.viewModel.authorID = authorID
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = PostDetailScreenRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSaveBtn()
        viewModel.getPostDetails()
    }
    
    private func configureSaveBtn() {
        let saveButton = UIButton()
        saveButton.setImage(R.image.save_inactive_icon(), for: .normal)
        saveButton.setImage(R.image.save_active_icon(), for: .selected)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
