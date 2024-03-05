//
//  NeoBlogPostRemoteAPI.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation
import Alamofire

struct NeoBlogPostRemoteAPI: PostRemoteAPI {
    
    //MARK: Properties
    private let apiManager: APIManager
    private let mapper: JSONMapper
    private let userSession: UserSession
    
    //MARK: Methods
    init(userSession: UserSession,
        apiManager: APIManager = RESTAPIManager(),
         mapper: JSONMapper = JSONMapperImplementation()) {
        self.userSession = userSession
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    //GET
    func getBlogPost(categoryName: String, query: String, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getPostList(categoryName: categoryName, query: query))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: BlogPostListResponseModel.self))
        }
    }
    
    func getMyPosts(callback: @escaping (Result<[BlogPost], Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getMyPosts)
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [BlogPost].self))
        }
    }
    
    func getPostDetail(postID: Int, callback: @escaping (Result<BlogPost, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getPostDetail(postID: postID))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: BlogPost.self))
        }
    }
    
    func getUserCollections(userID: Int, callback: @escaping (Result<[Collection], Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getUserCollections(userID: userID))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [Collection].self))
        }
    }
    
    //POST
    func savePostToCollection(requestModel: AddPostToCollectionRequestModel, collectionID: Int, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void) {
        
    }
    
    func createCollection(authorID: Int, requestModel: CreateCollection, callback: @escaping (Result<CreateCollection, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .createCollection(authorID: authorID, requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: CreateCollection.self))
        }
    }
    
    //Create Comment
    func createComment(requestModel: CreateCommentRequestModel, callback: @escaping (Result<CreateCommentRequestModel, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .createCommment(requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: CreateCommentRequestModel.self))
        }
    }
    
    func createPost(requestModel: CreateAndUpdatePostRequestModel, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void) {
        
    }
    
    //UPDATE
    func updateCollection(collectionID: Int, requestModel: UpdateCollectionRequestModel, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void) {
        
    }
    
    func updatePost(postID: Int, requestModel: CreateAndUpdatePostRequestModel, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void) {
        
    }
    
    //DELETE
    func deleteCollection(collectionID: Int, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void) {
        
    }
    
    func deletePost(postID: Int, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void) {
        
    }
}
