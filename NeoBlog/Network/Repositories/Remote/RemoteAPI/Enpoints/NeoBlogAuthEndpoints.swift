//
//  NeoBlogAuthEndpoints.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Alamofire

extension NeoBlogAuthEndpoints {
    enum Endpoints {
        case userMe
        case signIn(requestModel: SignInRequestModel)
        case signUp(requestModel: SignUpRequestModel)
        case sendOTP(requestModel: SendOTPRequestModel)
        case verifyOTP(requestModel: VerifyOTPRequestModel)
        case changeForgotPassword(token: String, requestModel: ChangeForgotPasswordRequestModel)
    }
}

struct NeoBlogAuthEndpoints: RESTEnpoint {
    
    //MARK: Properties
    
    private let userSession: UserSession?
    private let endpointType: Endpoints
    
    //MARK: Methods
    init(userSession: UserSession?, endpointType: Endpoints) {
        self.userSession = userSession
        self.endpointType = endpointType
    }
    
    var method: HTTPMethod {
        switch endpointType {
        case .userMe:
            return .get
        default:
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch endpointType {
        default:
            return nil
        }
    }
    
    var encodableParameters: Encodable {
        switch endpointType {
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
        default:
            return ""
        }
    }
    
    var encoder: JSONParameterEncoder {
        switch endpointType {
        default:
            return JSONParameterEncoder.default
        }
    }
    
    var url: String? {
        switch endpointType {
        case .userMe:
            return "/users/me/"
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
        if let userSession {
            let token = userSession.remoteSession.accessToken
            return ["Content-type": "application/json", "Authorization": "Bearer \(token)"]
        } else {
            return ["Content-type": "application/json"]
        }
    }
}
