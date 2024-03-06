//
//  MainScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Combine

enum MainScreenViewState {
    case initial
    case sortByCategorySheet
    case postsCollectionSheet(savedCollectionID: Int?, postID: Int)
}

class MainScreenViewModel {
    
    //MARK: Properties
    
    @Published private(set) var view: MainScreenViewState = .initial
    @Published private(set) var blogPostList: [BlogPost] = []
    
    private let goToPostDetailsNavigator: GoToPostDetailsNavigator
    
    private let userProfile: UserProfile
    private let postRepository: PostRepository
    
    //MARK: Methods
    
    init(userProfile: UserProfile,
         postRepository: PostRepository,
         goToPostDetailsNavigator: GoToPostDetailsNavigator) {
        self.userProfile = userProfile
        self.postRepository = postRepository
        self.goToPostDetailsNavigator = goToPostDetailsNavigator
        print(userProfile)
    }
    
    func navigateToPostDetails(with postID: Int) {
        goToPostDetailsNavigator.navigateToPostDetails(postID: postID)
    }
    
    //Search
    func search(with text: String?) {
        getBlogPostList(query: text ?? "")
    }
    
    // Filter by category
    func filterByCategory(item: CategoryItem) {
        getBlogPostList(categoryName: item.title)
    }
    
    // Open Filter Sheet
    func openFilterSheet() {
        view = .sortByCategorySheet
    }
    
    //Open Post Collection Sheet
    func openPostCollectionSheet(collectionID: Int?, postID: Int) {
        view = .postsCollectionSheet(savedCollectionID: collectionID, postID: postID)
    }
}

extension MainScreenViewModel {
    func getBlogPostList(categoryName: String = "", query: String = "") {
        postRepository
            .getBlogPostList(categoryName: categoryName, query: query)
            .done({ blogList in
                self.blogPostList = blogList
            })
            .catch { error in
                print(error)
            }
    }
}
