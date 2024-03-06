//
//  SignedInRequestModels.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 02/03/24.
//

import Foundation

//Post
struct CreateAndUpdatePostRequestModel: Codable {
    let title: String
    let description: String
    let photo: String
    let author: Int
    let category: Int
}

//Create Comment
struct CreateCommentRequestModel: Codable {
    let post: Int
    let author: Int
    let text: String
}

//Create Collection
struct CreateCollection: Codable {
    let name: String
}

//Add Post To Collection
struct AddPostToCollectionRequestModel: Encodable {
    let postID: Int
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
    }
}

//Update Collection
struct UpdateCollectionRequestModel {
    let name: String
    let author: Int
}
