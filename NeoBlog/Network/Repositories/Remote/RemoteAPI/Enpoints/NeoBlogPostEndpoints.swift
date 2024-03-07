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
        case getCategoriesList
        case getPostDetail(postID: Int)
        case getUserCollections(userID: Int)
        case getPostList(categoryName: String, query: String, startDate: String, endDate: String, period: String)
        
        //Post
        case addPostToCollection(collectionID: Int, requestModel: AddPostToCollectionRequestModel)
        case createCollection(authorID: Int, requestModel: CreateCollection)
        case createCommment(requestModel: CreateCommentRequestModel)
        case createPost(parameters: [String: Any])
        
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
        case .getMyPosts, .getPostDetail, .getUserCollections, .getPostList, .getCategoriesList:
            return .get
        case .addPostToCollection, .createCollection, .createCommment, .createPost:
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
        case .createCommment(let requestModel):
            return requestModel
        case .addPostToCollection(_, let requestModel):
            return requestModel
        default:
            return ""
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch endpointType {
        case .getPostList(let categoryName, let query, let startDate, let endDate, let period):
            return ["category_name": categoryName,
                    "search": query,
                    "start_date": startDate,
                    "end_date": endDate,
                    "period": period ]
        case .createPost(let parameters):
            return parameters
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
            
        //get category list
        case .getCategoriesList:
            return "/blog/category/list/"
            
        //get my posts
        case .getMyPosts:
            return "/blog/my-posts/"
            
        //get post detail
        case .getPostDetail(let postID):
            return "/blog/post/detail/\(postID)/"
        
        //get user collections
        case .getUserCollections(let userID):
            return "/blog/collections/user/\(userID)/"
        
        //Get Posts List
        case .getPostList:
            return "/blog/post/list/"
            
        //Create Post
        case .createPost:
            return "/blog/post/create/"
            
        //Create Comment
        case .createCommment:
            return "/blog/comment-create/"
            
        //Add Post To Collection
        case .addPostToCollection(let collectionID, _):
            return "/blog/collections/\(collectionID)/add-post/"
            
        //Create Collection
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

