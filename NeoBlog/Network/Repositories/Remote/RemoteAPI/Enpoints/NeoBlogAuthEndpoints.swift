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
    case signUp(requestModel: SignUpRequestModel)
    case sendOTP(requestModel: SendOTPRequestModel)
    case verifyOTP(requestModel: VerifyOTPRequestModel)
    case changeForgotPassword(token: String, requestModel: ChangeForgotPasswordRequestModel)
}

extension NeoBlogAuthEndpoints {
    
    var method: HTTPMethod {
        switch self {
        default:
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
        case .signUp(let requestModel):
            return requestModel
        case .sendOTP(let requestModel):
            return requestModel
        case .verifyOTP(let requestModel):
            return requestModel
        case .changeForgotPassword(_, let requestModel):
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
        case .signUp:
            return "/users/register/"
        case .sendOTP:
            return "/users/forgot-password/"
        case .verifyOTP:
            return "/users/confirm-code/"
        case .changeForgotPassword:
            return "/users/change-forgot-password/"
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        
        case .changeForgotPassword(let token, _):
            return ["Content-type": "application/json", "Authorization": "Bearer \(token)"]
        default:
            return ["Content-type": "application/json"]
        }
    }
}
