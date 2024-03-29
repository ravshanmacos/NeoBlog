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
    
    //MARK: GET
    
    func getCategoriesList(callback: @escaping (Result<[Category], Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getCategoriesList)
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [Category].self))
        }
    }
    
    //get posts list
    func getBlogPost(categoryName: String, query: String, startDate: String, endDate: String, period: String,
                     callback: @escaping (Result<[BlogPost], Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getPostList(categoryName: categoryName, query: query, startDate: startDate, endDate: endDate, period: period))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [BlogPost].self))
        }
    }
    
    //get my posts
    func getMyPosts(callback: @escaping (Result<[BlogPost], Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getMyPosts)
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [BlogPost].self))
        }
    }
    
    //get collection posts
    func getCollectionPosts(collectionID: Int, callback: @escaping (Result<[BlogPost], Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getCollectionPosts(collectionID: collectionID))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [BlogPost].self))
        }
    }
    
    //get post details
    func getPostDetail(postID: Int, callback: @escaping (Result<BlogPost, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getPostDetail(postID: postID))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: BlogPost.self))
        }
    }
    
    //get user collections
    func getUserCollections(userID: Int, callback: @escaping (Result<[Collection], Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getUserCollections(userID: userID))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [Collection].self))
        }
    }
    
    //add post To Collection
    func addPostToCollection(requestModel: AddPostToCollectionRequestModel, collectionID: Int, callback: @escaping (Result<GeneralResponse, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .addPostToCollection(collectionID: collectionID, requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: GeneralResponse.self))
        }
    }
    
    //MARK: POST
    
    //create collection
    func createCollection(authorID: Int, requestModel: CreateCollection, callback: @escaping (Result<CreateCollection, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .createCollection(authorID: authorID, requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: CreateCollection.self))
        }
    }
    
    //create comment
    func createComment(requestModel: CreateCommentRequestModel, callback: @escaping (Result<CreateCommentRequestModel, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .createCommment(requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: CreateCommentRequestModel.self))
        }
    }
    
    //create post
    func createPost(parameters: [String: Any], callback: @escaping (Result<CreateAndUpdatePostRequestModel, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .createPost(parameters: parameters))
        apiManager.multipartRequest(endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: CreateAndUpdatePostRequestModel.self))
        }
    }
    
    //MARK: PUT
    
    func updateCollection(collectionID: Int, requestModel: UpdateCollectionRequestModel, callback: @escaping (Result<Collection, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .updateCollection(collectionID: collectionID, requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: Collection.self))
        }
    }
    
    func updatePost(postID: Int, parameters: [String: Any], callback: @escaping (Result<CreateAndUpdatePostRequestModel, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .updatePost(postID: postID, parameters: parameters))
        apiManager.multipartRequest(endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: CreateAndUpdatePostRequestModel.self))
        }
    }
    
    func updateLoginAndEmail(requestModel: UpdateLoginAndEmailRequestModel, callback: @escaping (Result<GeneralResponse, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .updateLoginAndEmail(requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: GeneralResponse.self))
        }
    }
    
    func updatePassword(requestModel: UpdatePasswordRequestModel, callback: @escaping (Result<GeneralResponse, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .updatePassword(requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: GeneralResponse.self))
        }
    }
    
    //MARK: DELETE
    
    func deleteCollection(collectionID: Int, callback: @escaping (Result<String, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .deleteCollection(collectionID: collectionID))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            switch response {
            case .success: callback(.success("Success"))
            case .failure(let error): callback(.failure(error))
            }
        }
    }
    
    func deletePost(postID: Int, callback: @escaping (Result<String, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .deletePost(postID: postID))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            switch response {
            case .success: callback(.success("Success"))
            case .failure(let error): callback(.failure(error))
            }
        }
    }
}
