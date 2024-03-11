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
    private let goToAddPostNavigator: GoToAddPostNavigator
    var authorID: Int?
    var postID: Int?
    
    //MARK: Methods
    init(postRepository: PostRepository, goToAddPostNavigator: GoToAddPostNavigator) {
        self.postRepository = postRepository
        self.goToAddPostNavigator = goToAddPostNavigator
    }
    
    func navigateToAddPost() {
        guard let post else { return }
        goToAddPostNavigator.navigateToAddPost(post: post)
    }
    
    func isAuthorCreatedPost() -> Bool {
        guard let post, let isAuthor = post.isAuthor else { return false }
        return isAuthor
    }
    
    func deletePost(_ completion: @escaping (() -> Void)) {
        guard let postID else { return }
        postRepository
            .deletePost(postID: postID)
            .done { message in
                print(message)
                completion()
            }.catch { error in
                print(error)
            }
    }
    
    func getPostDetails(_ completion: @escaping (() -> Void)) {
        guard let postID else { return }
        postRepository
            .getPostDetail(postID: postID)
            .done({ post in
                self.post = post
                completion()
            })
            .catch { error in
                print(error)
            }
    }
    
    func createComment(with text: String, _ completion: @escaping ( () -> Void)) {
        guard let authorID else { return }
        guard let postID else { return }
        let requestModel = CreateCommentRequestModel(post: postID, author: authorID, text: text)
        postRepository
            .createComment(requestModel: requestModel)
            .done({ comment in
                print(comment)
                self.getPostDetails({})
                completion()
            })
            .catch { error in
                print(error)
            }
    }
}
