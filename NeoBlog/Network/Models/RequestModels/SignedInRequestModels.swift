//
//  SignedInRequestModels.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 02/03/24.
//

import Foundation

//Post
struct CreateAndUpdatePostRequestModel: Encodable {
    let title: String
    let description: String
    let author: Int
    let category: Int
}

struct CreateCommentRequestModel: Codable {
    let post: Int
    let author: Int
    let text: String
}

struct CreateCollection: Codable {
    let name: String
}

struct AddPostToCollectionRequestModel: Encodable {
    let postID: Int
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
    }
}

//PUT
struct UpdateCollectionRequestModel {
    let name: String
    let author: Int
}
