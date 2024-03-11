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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPostDetails {
            self.viewModel.isAuthorCreatedPost() ? self.addSaveAndMenuBtnsToRight() : self.addSaveBtnToRight()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func menuButtonTapped() {
        presentEditOrDeletePostSheet()
    }
    
    override func saveButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    private func presentEditOrDeletePostSheet() {
        let editPostSheet = SecondaryTwoActionSheet(viewModel: self, title: "Еще", firstActionBtnTitle: "Редактировать пост", secondActionBtnTitle: "Удалить пост", sheetFirstActionBtnImage: R.image.edit_icon()!, sheetSecondActionBtnImage: R.image.trash_bin_icon()!)
        navigationController?.presentPanModal(editPostSheet)
    }
    
    private func presentEditCollectionSheet() {
        print("presentEditCollectionSheet")
    }
    
    private func presentDeletePostSheet() {
        let editCollectionSheet = PrimaryTwoActionSheet(viewModel: self, title: "Удалить подборку?", subtitle: "Подборка удалится вместе со всеми сохраненными в ней постами", firstActionBtnTitle: "Удалить", secondActionBtnTitle: "Отмена")
        navigationController?.presentPanModal(editCollectionSheet)
    }
}

extension PostDetailScreenViewController: SecondaryTwoActionSheetViewModel {
    func secondaryTwoActionSheetFirstBtnTapped() {
        print("Show Edit Process displayed")
        dismiss(animated: true) {
            self.viewModel.navigateToAddPost()
        }
        
    }
    
    func secondaryTwoActionSheetSecondBtnTapped() {
        dismiss(animated: true) {
            self.presentDeletePostSheet()
        }
    }
}

extension PostDetailScreenViewController: PrimaryTwoActionSheetViewModel {
    func primaryTwoActionSheetFirstBtnTapped() {
        dismiss(animated: true) {
            self.viewModel.deletePost {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func primaryTwoActionSheetSecondBtnTapped() {
        dismiss(animated: true)
    }
}
