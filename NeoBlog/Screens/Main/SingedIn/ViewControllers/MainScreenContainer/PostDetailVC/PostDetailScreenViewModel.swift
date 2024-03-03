//
//  PostDetailScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation

class PostDetailScreenViewModel {
    //MARK: Properties
    
    @Published private(set) var post: BlogPost? = nil
    private let postRepository: PostRepository
    var postID: Int?
    
    //MARK: Methods
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    func getPostDetails() {
        guard let postID else { return }
        postRepository
            .getPostDetail(postID: postID)
            .done({ post in
                self.post = post
            })
            .catch { error in
                print(error)
            }
    }
}
