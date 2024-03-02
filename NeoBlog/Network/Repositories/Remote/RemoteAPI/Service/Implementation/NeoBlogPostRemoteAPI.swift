//
//  NeoBlogPostRemoteAPI.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation
import Alamofire

struct NeoBlogPostRemoteAPI: PostRemoteAPI {
    
    //MARK: Properties
    private let apiManager: APIManager
    private let mapper: JSONMapper
    private let userSession: UserSession
    
    //MARK: Methods
    init(userSession: UserSession,
        apiManager: APIManager = RESTAPIManager(),
         mapper: JSONMapper = JSONMapperImplementation()) {
        self.userSession = userSession
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    func getBlogPost(categoryName: String, query: String, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void) {
        let endpoint = NeoBlogPostEndpoints(userSession: userSession, endpointType: .getBlogPostList(categoryName: categoryName, query: query))
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: BlogPostListResponseModel.self))
        }
    }
}
