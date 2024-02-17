//
//  NeoBlogEnpoint.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import Foundation

enum NeoBlogAPI {
    case signIn(email: String, password: String)
}

extension NeoBlogAPI: EndpointType {
    var enviromentBaseURL: String {
        switch NetworkManager.enviroment {
        case .production: return Secrets.baseURL.rawValue
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: enviromentBaseURL) else { fatalError("Base url couldn't be configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/users/login/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .signIn(let email, let password):
            let body: [String: Any] = ["email": email, "password": password]
            return .requestWithParameters(bodyParameters: body, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
