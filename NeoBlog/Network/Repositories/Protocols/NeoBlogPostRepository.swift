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
    
    //MARK: Get
    
    //Get My Posts
    func getMyPosts() -> Promise<[BlogPost]> {
        return Promise<[BlogPost]> { resolver in
            remoteAPI.getMyPosts { result in
                switch result {
                case .success(let posts):
                    resolver.fulfill(posts)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    // Get Categories List
    func getCategoriesList() -> Promise<[Category]> {
        return Promise<[Category]> { resolver in
            remoteAPI.getCategoriesList() { result in
                switch result {
                case .success(let categories):
                    resolver.fulfill(categories)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    
    //Get Post Details
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
    
    //Get User Collections
    
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

    //Get Posts List
    
    func getBlogPostList(categoryName: String, query: String, startDate: String, endDate: String, period: String) -> Promise<[BlogPost]> {
        return Promise<[BlogPost]> { resolver in
            remoteAPI.getBlogPost(categoryName: categoryName, query: query, startDate: startDate, endDate: endDate, period: period) { result in
                switch result {
                case .success(let model):
                    resolver.fulfill(model)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
   
    
    
    //MARK: POST
    
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
    
    //Create Post
    func createPost(parameters: [String: Any]) -> Promise<CreateAndUpdatePostRequestModel> {
        return Promise<CreateAndUpdatePostRequestModel> { resolver in
            remoteAPI.createPost(parameters: parameters) { result in
                switch result {
                case .success(let data):
                    resolver.fulfill(data)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    //Add Post To Collection
    func addPostToCollection(collectionID: Int, requestModel: AddPostToCollectionRequestModel) -> Promise<GeneralResponse> {
        return Promise<GeneralResponse> { resolver in
            remoteAPI.addPostToCollection(requestModel: requestModel, collectionID: collectionID) { result in
                switch result {
                case .success(let data):
                    resolver.fulfill(data)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    //MARK: Update
    func updateLoginAndEmail(requestModel: UpdateLoginAndEmailRequestModel) -> Promise<GeneralResponse> {
        return Promise<GeneralResponse> { resolver in
            remoteAPI.updateLoginAndEmail(requestModel: requestModel) { result in
                switch result {
                case .success(let data):
                    resolver.fulfill(data)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func updatePassword(requestModel: UpdatePasswordRequestModel) -> Promise<GeneralResponse> {
        return Promise<GeneralResponse> { resolver in
            remoteAPI.updatePassword(requestModel: requestModel) { result in
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
