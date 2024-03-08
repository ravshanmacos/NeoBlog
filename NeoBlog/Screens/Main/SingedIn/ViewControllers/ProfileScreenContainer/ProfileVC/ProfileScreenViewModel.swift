//
//  ProfileScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Combine

enum ProfileScreenState {
    case initial
    case tableviewIsEmpty
    case tableviewNotEmpty
}

class ProfileScreenViewModel: EmptyPostViewModel {

    //MARK: Properties
    @Published private(set) var collections: [Collection] = []
    private(set) var posts: [BlogPost] = []
    
    
    @Published private(set) var openCreatePostCollectionSheet = false
    @Published private(set) var viewState: ProfileScreenState = .tableviewIsEmpty
    
    private let postRepository: PostRepository
    private let goToEditProfileSheetNavigator: GoToEditProfileSheetNavigator
    private let goToCollectionPostsNavigator: GoToCollectionPosts
    
    var userID: Int?
    
    //MARK: Methods
    init(postRepository: PostRepository,
         goToEditProfileSheetNavigator: GoToEditProfileSheetNavigator,
         goToCollectionPostsNavigator: GoToCollectionPosts) {
        self.postRepository = postRepository
        self.goToEditProfileSheetNavigator = goToEditProfileSheetNavigator
        self.goToCollectionPostsNavigator = goToCollectionPostsNavigator
    }
    
    func createPostTapped() {
        
    }
    
    func setTableviewState() {
        viewState = posts.isEmpty ? .tableviewIsEmpty : .tableviewNotEmpty
    }
    
    func collectionItemTapped(for index: Int) {
        let collection = collections[index]
        goToCollectionPostsNavigator.navigateToCollectionPosts(collection: collection)
    }
}

@objc extension ProfileScreenViewModel {
   func openEditProfileSheet() {
        goToEditProfileSheetNavigator.navigateToEditProfileSheet()
    }
    
    func addCollectionBtnTapped() {
        openCreatePostCollectionSheet = true
    }
}

//MARK: Networking
extension ProfileScreenViewModel {
    func getMyPosts() {
        postRepository
            .getMyPosts()
            .done { posts in
                self.posts = posts
                self.setTableviewState()
            }.catch { error in
                print(error)
            }
    }
    
    func getCollections() {
        guard let id = userID else { return }
        postRepository
            .getUserCollections(userID: id)
            .done { collections in
                self.collections = collections
            }.catch { error in
                print(error)
            }
    }
    
    func logout() {
        
    }
}
