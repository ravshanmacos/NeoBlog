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
        case getCollectionPosts(collectionID: Int)
        case getPostList(categoryName: String, query: String, startDate: String, endDate: String, period: String)
        
        //Post
        case addPostToCollection(collectionID: Int, requestModel: AddPostToCollectionRequestModel)
        case createCollection(authorID: Int, requestModel: CreateCollection)
        case createCommment(requestModel: CreateCommentRequestModel)
        case createPost(parameters: [String: Any])
        
        //PUT
        case updateLoginAndEmail(requestModel: UpdateLoginAndEmailRequestModel)
        case updatePassword(requestModel: UpdatePasswordRequestModel)
        case updateCollection(collectionID: Int, requestModel: UpdateCollectionRequestModel)
        case updatePost(postID: Int, parameters: [String: Any])
        
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
        case .getMyPosts, .getCollectionPosts, .getPostDetail, .getUserCollections, .getPostList, .getCategoriesList:
            return .get
        case .addPostToCollection, .createCollection, .createCommment, .createPost:
            return .post
        case .updatePost, .updateCollection, .updateLoginAndEmail, .updatePassword:
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
            
        case .updateLoginAndEmail(let requestModel):
            return requestModel
        case .updatePassword(let requestModel):
            return requestModel
        case .updateCollection(_, let requestModel):
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
        case .updatePost(_, let parameters):
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
            
        //MARK: GET
        //get category list
        case .getCategoriesList:
            return "/blog/category/list/"
            
        //get my posts
        case .getMyPosts:
            return "/blog/my-posts/"
            
            //get my posts
        case .getCollectionPosts(let collectionID):
            return "/blog/collections/\(collectionID)/posts/"
            
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
            
        //MARK: Post
        //Add Post To Collection
        case .addPostToCollection(let collectionID, _):
            return "/blog/collections/\(collectionID)/add-post/"
            
        //Create Collection
        case .createCollection(let authorID, _):
            return "/blog/collections/\(authorID)/create/"
            
        //MARK: Update
        //Upate Post
        case .updatePost(let postID, _):
            return "/blog/post/\(postID)/update/"
            
        //Update Collection
        case .updateCollection(let collectionID, _):
            return "/blog/collection/\(collectionID)/update/"
            
        //Update Login and Email
        case .updateLoginAndEmail:
            return "/users/profile/update/"
            
        //Update Password
        case .updatePassword:
            return "/users/change-password/"
        
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

