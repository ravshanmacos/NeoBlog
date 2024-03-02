//
//  PostRepository.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation
import PromiseKit

protocol PostRepository {
    func getBlogPostList(categoryName: String, query: String) -> Promise<BlogPostListResponseModel>
}
