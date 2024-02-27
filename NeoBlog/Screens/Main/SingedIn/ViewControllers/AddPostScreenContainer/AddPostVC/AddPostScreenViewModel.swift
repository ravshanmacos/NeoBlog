//
//  AddPostScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation

class AddPostScreenViewModel {
    
    //MARK: Properties
    @Published private(set) var addPostScreenState: AddPostScreenState?
    
    //MARK: Methods
    
    @objc func closeBtnTapped() {
        addPostScreenState = .closeVC
    }
    
    func chooseFromLibrary() {
        addPostScreenState = .chooseFromLibrary
    }
    
    func takePhotoOrVideo() {
        addPostScreenState = .takePhotoOrVideo
    }
    
    func chooseFile() {
        addPostScreenState = .chooseFile
    }
}
