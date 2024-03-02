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
        case getBlogPostList(categoryName: String, query: String)
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
        case .getBlogPostList:
            return .get
        }
    }
    
    var encodableParameters: Encodable {
        switch endpointType {
        default:
            return ""
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch endpointType {
        case .getBlogPostList(let categoryName, let query):
            return ["category_name": categoryName, "search": query]
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
        case .getBlogPostList:
            return "/blog/post/list/"
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        return ["Content-type": "application/json", "Authorization": "Bearer \(userSession.remoteSession.accessToken)"]
    }
}

