//
//  NeoBlogPostRepository.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation
import PromiseKit

class NeoBlogPostRepository: PostRepository {
    //MARK: Methods
    private let remoteAPI: PostRemoteAPI
    
    //MARK: Properties
    init(remoteAPI: PostRemoteAPI) {
        self.remoteAPI = remoteAPI
    }
    
    func getBlogPostList(categoryName: String, query: String) -> Promise<BlogPostListResponseModel> {
        return Promise<BlogPostListResponseModel> { resolver in
            remoteAPI.getBlogPost(categoryName: categoryName, query: query) { result in
                switch result {
                case .success(let model):
                    resolver.fulfill(model)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func getPostDetail(postID: Int) -> PromiseKit.Promise<BlogPost> {
        return Promise<BlogPost> { resolver in
            remoteAPI.getPostDetail(postID: postID) { result in
                switch result {
                case .success(let post):
                    resolver.fulfill(post)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func getUserCollections(userID: Int) -> Promise<[Collection]> {
        return Promise<[Collection]> { resolver in
            remoteAPI
                .getUserCollections(userID: userID) { result in
                    switch result {
                    case .success(let collections):
                        resolver.fulfill(collections)
                    case .failure(let error):
                        resolver.reject(error)
                    }
                }
        }
    }
    
    //Create Collection
    func createCollection(authorID: Int, requestModel: CreateCollection) -> Promise<CreateCollection> {
        return Promise<CreateCollection> { resolver in
            remoteAPI.createCollection(authorID: authorID, requestModel: requestModel) { result in
                switch result {
                case .success(let data):
                    resolver.fulfill(data)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    //Create Comment
    func createComment(requestModel: CreateCommentRequestModel) -> Promise<CreateCommentRequestModel> {
        return Promise<CreateCommentRequestModel> { resolver in
            remoteAPI.createComment(requestModel: requestModel) { result in
                switch result {
                case .success(let data):
                    resolver.fulfill(data)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
}
