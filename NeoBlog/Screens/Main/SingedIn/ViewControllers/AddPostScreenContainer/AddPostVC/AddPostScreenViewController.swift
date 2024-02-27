//
//  AddPostScreenViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit
import Combine

protocol AddPostViewModelFactory {
    func makeAddPostViewModel() -> AddPostScreenViewModel
}

class AddPostScreenViewController: BaseNavigationController {
    
    //MARK: Properties
    private let viewModelFactory: AddPostViewModelFactory
    private let viewModel: AddPostScreenViewModel
    
    private let imagePicker = UIImagePickerController()
    private var subscriptions = Set<AnyCancellable>()
    
    private var rootView: AddPostScreenRootView {
        return view as! AddPostScreenRootView
    }
    
    //MARK: Methods
    
    init(viewModelFactory: AddPostViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeAddPostViewModel()
        super.init()
        observeUploadStates()
    }
    
    override func loadView() {
        super.loadView()
        self.view = AddPostScreenRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    private func observeUploadStates() {
        viewModel
            .$addPostScreenState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                guard let self, let state else { return }
                self.respond(to: state)
            }.store(in: &subscriptions)
    }
    func respond(to state: AddPostScreenState) {
        switch state {
        case .takePhotoOrVideo:
            self.imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
        case .chooseFromLibrary:
            self.imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        case .chooseFile:
            print("Choose file")
            //self.imagePicker.sourceType = .savedPhotosAlbum
        case .removeChosen:
            print("Remove file tapped")
        case .closeVC:
            closeAddPostScreen()
        }
    }
    
    private func closeAddPostScreen() {
        dismiss(animated: true) {
            self.tabBarController?.selectedIndex = 0
        }
    }
}

extension AddPostScreenViewController:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            rootView.setUploadedImageState(with: pickedImage)
        }
        dismiss(animated: true)
    }
}
