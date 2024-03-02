//
//  BlogPostListResponseModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation

/*
 page": 1,
     "count": 21,
     "next": "https://neobook.online/neoblog/blog/post/list/?page=2",
     "previous": null,
     "results": [
         {
             "id": 21,
             "title": "Что за белый порошок, которым мажут руки гимнасты?",
             "description": "Многие ошибочно полагают, что перед выступлением гимнасты растирают в руках муку, но это не так. Белый порошок магнезии удаляет с руки даже мелкие следы влаги, помогая улучшить сцепление со снарядом.",
             "photo": "https://res.cloudinary.com/neomedtech/image/upload/v1/media/post_photos/%D0%BF%D0%BE%D1%80%D0%BE%D1%88%D0%BE%D0%BA_vdhsfl",
             "author": {
                 "id": 1,
                 "username": null
             },
             "category": {
                 "id": 3,
                 "name": "Спорт"
             },
             "publication_date": "02 февр в 13:51",
             "comments_count": 0,
             "in_collections": false
         },
      ]
 */

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
    let author: Author
    let category: Category
    let publicationDate: String?
    let commentsCount: Int?
    let inCollections: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, photo
        case author, category
        case publicationDate = "publication_date"
        case commentsCount = "comments_count"
        case inCollections = "in_collections"
    }
}

struct Author: Decodable {
    let id: Int?
    let name: String?
}

struct Category: Decodable {
    let id: Int?
    let name: String?
}
