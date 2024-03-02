//
//  NeoBlogPostRepository.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation
import PromiseKit

class NeoBlogPostRepository: PostRepository {
    private let remoteAPI: PostRemoteAPI
    
    init(remoteAPI: PostRemoteAPI) {
        self.remoteAPI = remoteAPI
    }
    
    func getBlogPostList(categoryName: String, query: String) -> Promise<BlogPostListResponseModel> {
        return Promise<BlogPostListResponseModel> { resolver in
            remoteAPI.getBlogPost(categoryName: categoryName, query: query) { result in
                switch result {
                case .success(let model):
                    resolver.fulfill(model)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
}
