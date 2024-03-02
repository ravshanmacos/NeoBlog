//
//  PostRemoteAPI.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation

protocol PostRemoteAPI {
    func getBlogPost(categoryName: String, query: String, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
}
