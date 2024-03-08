//
//  NeoBlogAuthRemoteAPI.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Alamofire

struct NeoBlogAuthRemoteAPI: AuthRemoteAPI {
    
    //MARK: Properties
    private let apiManager: APIManager
    private let mapper: JSONMapper
    
    //MARK: Methods
    init(apiManager: APIManager = RESTAPIManager(), mapper: JSONMapper = JSONMapperImplementation()) {
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    func userMe(userSession: UserSession, callback: @escaping (Result<UserProfile, Error>) -> Void) {
        let endpoint = NeoBlogAuthEndpoints(userSession: userSession, endpointType: .userMe)
        apiManager.request(withEncodable: false, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: UserProfile.self))
        }
    }
    
    func sigIn(requestModel: SignInRequestModel, callback: @escaping (Result<SignInResponseModel, Error>) -> Void) {
        let endpoint = NeoBlogAuthEndpoints(userSession: nil, endpointType: .signIn(requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SignInResponseModel.self))
        }
    }
    
    func signUp(requestModel: SignUpRequestModel, callback: @escaping (Result<SignUpResponseModel, Error>) -> Void) {
        let endpoint = NeoBlogAuthEndpoints(userSession: nil, endpointType: .signUp(requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SignUpResponseModel.self))
        }
    }
    
    func forgotPassword(requestModel: SendOTPRequestModel, callback: @escaping (Result<GeneralResponse, Error>) -> Void) {
        let endpoint = NeoBlogAuthEndpoints(userSession: nil, endpointType: .sendOTP(requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: GeneralResponse.self))
        }
    }
    
    func verifyOTP(requestModel: VerifyOTPRequestModel, callback: @escaping (Result<VerifyOTPResponseModel, Error>) -> Void) {
        let endpoint = NeoBlogAuthEndpoints(userSession: nil, endpointType: .verifyOTP(requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: VerifyOTPResponseModel.self))
        }
    }
    
    func changePassword(token: String, requestModel: ChangeForgotPasswordRequestModel, callback: @escaping (Result<GeneralResponse, Error>) -> Void) {
        let userSession = UserSession(remoteSession: .init(accessToken: token, refreshToken: ""))
        let endpoint = NeoBlogAuthEndpoints(userSession: userSession, endpointType: .changeForgotPassword(token: token, requestModel: requestModel))
        apiManager.request(withEncodable: true, endpoint: endpoint) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: GeneralResponse.self))
        }
    }
}
