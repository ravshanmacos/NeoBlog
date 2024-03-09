//
//  BlogPostListResponseModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation

struct BlogPostListResponseModel: Decodable {
    let page: Int?
    let next: String?
    let previous: String?
    let results: [BlogPost]
}

struct BlogPost: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let photo: String?
    let author: Author?
    let category: Category
    let publicationDate: String?
    let postComments: [Comment]?
    let commentsCount: Int?
    let inCollections: Bool?
    let collectionInfo: [CollectionInfo]?
    let isAuthor: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, photo
        case author, category
        case publicationDate = "publication_date"
        case postComments = "post_comments"
        case commentsCount = "comments_count"
        case inCollections = "in_collections"
        case collectionInfo = "collection_info"
        case isAuthor = "is_author"
    }
    
    func getImageURL() -> URL? {
        guard let imageURLString = photo else { return nil }
        guard let url = URL(string: imageURLString) else { return nil }
        return url
    }
}

struct CollectionInfo: Decodable {
    let id: Int?
    let name: String?
    let authorID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case authorID = "author"
    }
}

struct Comment: Decodable {
    let author: Author?
    let text: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case author, text
        case createdAt = "created_at"
    }
}

struct Author: Decodable {
    let id: Int?
    let username: String?
}

struct Category: Decodable {
    let id: Int?
    let name: String?
    var active: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
}

struct Collection: Decodable {
    let id: Int?
    let name: String?
    let postCount: Int?
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case postCount = "post_count"
    }
}


