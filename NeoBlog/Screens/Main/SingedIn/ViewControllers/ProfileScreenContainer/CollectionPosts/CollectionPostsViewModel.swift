//
//  CollectionPostsViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 08/03/24.
//

import Foundation

enum CollectionPostsState {
    case initial
    case postsEmpty
    case postsNotEmpty
}

class CollectionPostsViewModel {
    
    //MARK: Properties
    
    @Published private(set) var posts: [BlogPost] = []
    @Published private(set) var viewState: CollectionPostsState = .initial
    
    private let postRepository: PostRepository
    private let userProfile: UserProfile
    private let collection: Collection
    
    //MARK: Methods
    
    init(collection: Collection,  userProfile: UserProfile, postRepository: PostRepository) {
        self.collection = collection
        self.userProfile = userProfile
        self.postRepository = postRepository
    }
    
    func getCollectionName() -> String? {
        return collection.name
    }
    
    func setTableView() {
        viewState = posts.isEmpty ? .postsEmpty : .postsNotEmpty
    }
    
    func updateCollection(newCollectionName: String, completion: @escaping (() -> Void)) {
        guard let collectionID = collection.id, let authorID = userProfile.id else { return }
        let requestModel = UpdateCollectionRequestModel(name: newCollectionName, author: authorID)
        postRepository
            .updateCollection(collectionID: collectionID, requestModel: requestModel)
            .done { collection in
                print(collection)
                completion()
            }.catch { error in
                print(error)
            }
    }
    
    func deleteCollection(completion: @escaping (() -> Void)) {
        guard let collectionID = collection.id else { return }
        postRepository
            .deleteCollection(collectionID: collectionID)
            .done { message in
                print(message)
                completion()
            }.catch { error in
                print(error)
            }
    }
    
    func getCollectionPostList() {
        guard let collectionID = collection.id else { return }
        postRepository
            .getCollecitonPosts(collectionID: collectionID)
            .done { posts in
                self.posts = posts
                self.setTableView()
            }.catch { error in
                print(error)
            }
    }
}
