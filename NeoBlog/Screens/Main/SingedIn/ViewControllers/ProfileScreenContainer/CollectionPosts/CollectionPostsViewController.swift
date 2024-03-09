//
//  CollectionPostsViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 08/03/24.
//

import UIKit
import Combine

protocol CollectionPostsViewModelFactory {
    func makeCollectionPostsViewModel(collection: Collection) -> CollectionPostsViewModel
}

class CollectionPostsViewController: BaseViewController {
    //MARK: Properties
    
    private let viewModelFactory: CollectionPostsViewModelFactory
    private let viewModel: CollectionPostsViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(collection: Collection, viewModelFactory: CollectionPostsViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeCollectionPostsViewModel(collection: collection)
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = CollectionPostsRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        viewModel.getCollectionPostList()
    }
    
    private func configureNavBar() {
        addTitle(text: "Избранное")
        addMenuBtnToRight()
    }
    
    override func menuButtonTapped() {
        presentEditOrDeleteCollectionSheet()
    }
    
    private func presentEditOrDeleteCollectionSheet() {
        let editOrDeleteCollectionSheet = SecondaryTwoActionSheet(viewModel: self, title: "Еще", firstActionBtnTitle: "Переименовать подборку", secondActionBtnTitle: "Удалить подборку", sheetFirstActionBtnImage: R.image.edit_icon()!, sheetSecondActionBtnImage: R.image.trash_bin_icon()!)
        navigationController?.presentPanModal(editOrDeleteCollectionSheet)
    }
    
    private func presentEditCollectionSheet() {
        let editCollectionSheet = CreateNewCollectionSheet(collectionName: viewModel.getCollectionName())
        editCollectionSheet.delegate = self
        navigationController?.presentPanModal(editCollectionSheet)
    }
    
    private func presentDeleteCollectionSheet() {
        let editCollectionSheet = PrimaryTwoActionSheet(viewModel: self, title: "Удалить подборку?", subtitle: "Подборка удалится вместе со всеми сохраненными в ней постами", firstActionBtnTitle: "Удалить", secondActionBtnTitle: "Отмена")
        navigationController?.presentPanModal(editCollectionSheet)
    }
}

extension CollectionPostsViewController: SecondaryTwoActionSheetViewModel, PrimaryTwoActionSheetViewModel, CreateNewCollectionSheetDelegate {
    func collectionDidCreated(with name: String) {
        dismiss(animated: true) {
            self.viewModel.updateCollection(newCollectionName: name) {[weak self] in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func primaryTwoActionSheetFirstBtnTapped() {
        print("Delete Collection")
        dismiss(animated: true) {
            self.viewModel.deleteCollection {[weak self] in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func primaryTwoActionSheetSecondBtnTapped() {
        print("Cancel Deletion")
        dismiss(animated: true)
    }
    
    func secondaryTwoActionSheetFirstBtnTapped() {
        print("Edit collection Tapped")
        dismiss(animated: true) {
            self.presentEditCollectionSheet()
        }
    }
    
    func secondaryTwoActionSheetSecondBtnTapped() {
        print("delete collection tapped")
        dismiss(animated: true) {
            self.presentDeleteCollectionSheet()
        }
    }
}


