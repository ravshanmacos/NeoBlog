//
//  PostCollectionSheetViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 25/02/24.
//

import Foundation
import Combine

class PostCollectionSheetViewModel {
    
    //MARK: Properties
    @Published private(set) var openCreatePostCollectionSheet = false
    @Published private(set) var collections: [Collection] = []
    
    private let postRepository: PostRepository
    private let userProfile: UserProfile
    
    //MARK: Methods
    init(postRepository: PostRepository, userProfile: UserProfile) {
        self.postRepository = postRepository
        self.userProfile = userProfile
    }
    
    func getCollections(activCategoryIndex: Int){
        guard let id = userProfile.id else { return }
        postRepository
            .getUserCollections(userID: id)
            .done({ collections in
                self.collections = collections
                self.collections[activCategoryIndex].isSelected = true
            })
            .catch { error in
                print(error)
            }
    }
    
    func unSelectAllOptions() {
        for index in 0..<collections.count {
            collections[index].isSelected = false
        }
    }
    
    func activateOption(for index: Int) {
        collections[index].isSelected = true
    }
    
    func addNewCollection(name: String) {
        guard let id = userProfile.id else { return }
        let requestModel = CreateCollection(name: name)
        postRepository
            .createCollection(authorID: id, requestModel: requestModel)
            .done {[weak self] name in
                guard let self else { return }
                print("Successfully created \(name) collection")
                self.getCollections(activCategoryIndex: self.collections.count)
            }.catch { error in
                print(error)
            }
    }
    
    @objc func addCollectionBtnTapped() {
        openCreatePostCollectionSheet = true
    }
}
