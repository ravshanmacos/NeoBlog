//
//  NeoBlogPostEndpoints.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation
import Alamofire



extension NeoBlogPostEndpoints {
    enum Endpoints {
        //Get
        case getMyPosts
        case getPostDetail(postID: Int)
        case getUserCollections(userID: Int)
        case getPostList(categoryName: String, query: String)
        
        //Post
        case savePostToCollection(collectionID: Int)
        case createCollection(authorID: Int, requestModel: CreateCollection)
        case createCommment
        case createPost
        
        //PUT
        case updateCollection(collectionID: Int)
        case updatePost(postID: Int)
        
        //Delete
        case deleteCollection(collectionID: Int)
        case deletePost(postID: Int)
    }
}

struct NeoBlogPostEndpoints: RESTEnpoint {
    private let userSession: UserSession
    private var endpointType: Endpoints
    
    init(userSession: UserSession, endpointType: Endpoints) {
        self.userSession = userSession
        self.endpointType = endpointType
    }
    
    var method: Alamofire.HTTPMethod {
        switch endpointType {
        case .getMyPosts, .getPostDetail, .getUserCollections, .getPostList:
            return .get
        case .savePostToCollection, .createCollection, .createCommment, .createPost:
            return .post
        case .updatePost, .updateCollection:
            return .put
        case .deletePost, .deleteCollection:
            return .delete
        }
    }
    
    var encodableParameters: Encodable {
        switch endpointType {
        case .createCollection(_, let requestModel):
            return requestModel
        default:
            return ""
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch endpointType {
        case .getPostList(let categoryName, let query):
            return ["category_name": categoryName, "search": query]
        default:
            return nil
        }
    }
    
    var encoder: Alamofire.JSONParameterEncoder {
        switch endpointType {
        default:
            return JSONParameterEncoder.default
        }
    }
    
    var url: String? {
        switch endpointType {
        //Get
        case .getMyPosts:
            return "/blog/my-post/s"
        case .getPostDetail(let postID):
            return "/blog/post/detail/\(postID)/"
        case .getUserCollections(let userID):
            return "/blog/collections/user/\(userID)/"
        case .getPostList:
            return "/blog/post/list/"
            
        //Post
        case .createPost:
            return "/blog/post/create/"
        case .createCommment:
            return "/blog/comment-create/"
        case .savePostToCollection(let collectionID):
            return "/blog/collections/\(collectionID)/add-post/"
        case .createCollection(let authorID, _):
            return "/blog/collections/\(authorID)/create/"
            
        //Put
        case .updatePost(let postID):
            return "/blog/post/\(postID)/update/"
        case .updateCollection(let collectionID):
            return "/blog/collection/\(collectionID)/update/"
        
        //Delete
        case .deletePost(let postID):
            return "/blog/post/\(postID)/delete/"
        case .deleteCollection(let collectionID):
            return "/blog/collection/\(collectionID)/delete/"
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        return ["Content-type": "application/json", "Authorization": "Bearer \(userSession.remoteSession.accessToken)"]
    }
}

