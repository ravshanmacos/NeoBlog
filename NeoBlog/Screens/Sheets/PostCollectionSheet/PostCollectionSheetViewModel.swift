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
    
    var collectionID: Int?
    var postID: Int?
    
    //MARK: Methods
    init(postRepository: PostRepository, userProfile: UserProfile) {
        self.postRepository = postRepository
        self.userProfile = userProfile
    }
    
    private func updateCollection(with collections: [Collection]) {
        let selectedCollectionIndex = collections.enumerated().compactMap { (index, collection) in
            return collection.id == collectionID ? index : nil
        }
        
        self.collections = collections
        if selectedCollectionIndex.count > 0 {
            for index in 0..<selectedCollectionIndex.count {
                self.collections[selectedCollectionIndex[index]].isSelected = true
            }
        }
    }
    
    func getCollections(){
        guard let id = userProfile.id else { return }
        postRepository
            .getUserCollections(userID: id)
            .done({ collections in
                self.updateCollection(with: collections)
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
        guard let collectionID = collections[index].id, let postID else { return }
        postRepository
            .addPostToCollection(collectionID: collectionID, requestModel: .init(postID: postID))
            .done({ response in
                print(response)
                self.collections[index].isSelected = true
            })
            .catch { error in
                print(error)
            }
        
    }
    
    func addNewCollection(name: String) {
        guard let id = userProfile.id else { return }
        let requestModel = CreateCollection(name: name)
        postRepository
            .createCollection(authorID: id, requestModel: requestModel)
            .done {[weak self] name in
                guard let self else { return }
                print("Successfully created \(name) collection")
                self.getCollections()
            }.catch { error in
                print(error)
            }
    }
    
    @objc func addCollectionBtnTapped() {
        openCreatePostCollectionSheet = true
    }
}
