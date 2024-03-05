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
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, photo
        case author, category
        case publicationDate = "publication_date"
        case postComments = "post_comments"
        case commentsCount = "comments_count"
        case inCollections = "in_collections"
    }
    func getImageURL() -> URL? {
        guard let imageURLString = photo else { return nil }
        guard let url = URL(string: imageURLString) else { return nil }
        return url
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
