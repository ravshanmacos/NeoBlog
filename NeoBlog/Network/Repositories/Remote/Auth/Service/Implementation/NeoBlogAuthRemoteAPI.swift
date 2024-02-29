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
    
    func sigIn(requestModel: SignInRequestModel, callback: @escaping (Result<SignInResponseModel, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: NeoBlogAuthEndpoints.signIn(requestModel: requestModel)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SignInResponseModel.self))
        }
    }
    
    func signUp(requestModel: SignUpRequestModel, callback: @escaping (Result<SignUpResponseModel, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: NeoBlogAuthEndpoints.signUp(requestModel: requestModel)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SignUpResponseModel.self))
        }
    }
    
    func forgotPassword(requestModel: SendOTPRequestModel, callback: @escaping (Result<GeneralResponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: NeoBlogAuthEndpoints.sendOTP(requestModel: requestModel)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: GeneralResponse.self))
        }
    }
    
    func verifyOTP(requestModel: VerifyOTPRequestModel, callback: @escaping (Result<VerifyOTPResponseModel, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: NeoBlogAuthEndpoints.verifyOTP(requestModel: requestModel)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: VerifyOTPResponseModel.self))
        }
    }
}
