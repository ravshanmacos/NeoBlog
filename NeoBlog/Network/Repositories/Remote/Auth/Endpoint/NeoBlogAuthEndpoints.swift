//
//  NeoBlogAuthEndpoints.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Alamofire

enum NeoBlogAuthEndpoints: RESTEnpoint {
    case signIn(requestModel: SignInRequestModel)
}

extension NeoBlogAuthEndpoints {
    
    var method: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var encodableParameters: Encodable {
        switch self {
        case .signIn(let requestModel):
            return requestModel
        }
    }
    
    var encoder: JSONParameterEncoder {
        switch self {
        default:
            return JSONParameterEncoder.default
        }
    }
    
    var url: String? {
        switch self {
        case .signIn:
            return "/users/login/"
        }
    }
}
