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
    var authorID: Int?
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
    
    func createComment(with text: String, _ completion: @escaping (()->Void)) {
        guard let authorID else { return }
        guard let postID else { return }
        let requestModel = CreateCommentRequestModel(post: postID, author: authorID, text: text)
        postRepository
            .createComment(requestModel: requestModel)
            .done({ comment in
                print(comment)
                self.getPostDetails()
                completion()
            })
            .catch { error in
                print(error)
            }
    }
}
