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
    case postsCollectionSheet(savedCollectionID: Int)
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
    
    // Open sheets
    func openFilterSheet() {
        view = .sortByCategorySheet
    }
    
    func openPostCollectionSheet() {
        //view = .postsCollectionSheet
    }
}

extension MainScreenViewModel {
    func getBlogPostList(categoryName: String = "", query: String = "") {
        postRepository
            .getBlogPostList(categoryName: categoryName, query: query)
            .done({ response in
                self.blogPostList = response.results
            })
            .catch { error in
                print(error)
            }
    }
}
