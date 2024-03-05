//
//  PostCollectionSheet.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 24/02/24.
//

import UIKit
import Combine
import PanModal

protocol PostCollectionViewModelFactory {
    func makePostCollectionViewModel() -> PostCollectionSheetViewModel
}

class PostCollectionSheet: BaseViewController, CreateNewCollectionSheetDelegate {
    
    //MARK: Properties
    private var rootView: PostCollectionRootView {
        return view as! PostCollectionRootView
    }
    private var subscriptions = Set<AnyCancellable>()
    
    private let viewModel: PostCollectionSheetViewModel
    private let viewModelFactory: PostCollectionViewModelFactory
    
    //MARK: Methods
    init(viewModelFactory: PostCollectionViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makePostCollectionViewModel()
        super.init()
        viewModel
            .$openCreatePostCollectionSheet
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, open else { return }
                self.presentPostCollectionSheet()
            }.store(in: &subscriptions)
    }
    
    override func loadView() {
        super.loadView()
        view = PostCollectionRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCollections(activCategoryIndex: 0)
        
    }
    
    private func presentPostCollectionSheet() {
        let createNewCollectionSheet = CreateNewCollectionSheet()
        createNewCollectionSheet.delegate = self
        presentPanModal(createNewCollectionSheet)
    }

    func collectionDidCreated(with name: String) {
        print("New Collection name is : \(name)")
        viewModel.addNewCollection(name: name)
    }
}

//MARK: Configure Sheet
extension PostCollectionSheet: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(350)
    }
}

