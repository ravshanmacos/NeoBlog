//
//  AuthRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import Alamofire

protocol AuthRemoteAPI {
    func sigIn(requestModel: SignInRequestModel,
               callback: @escaping (Result<SignInResponseModel, Error>) -> Void)
    
    func signUp(requestModel: SignUpRequestModel,
                callback: @escaping (Result<SignUpResponseModel, Error>) -> Void)
    func forgotPassword(requestModel: SendOTPRequestModel,
                callback: @escaping (Result<GeneralResponse, Error>) -> Void)
    func verifyOTP(requestModel: VerifyOTPRequestModel,
                callback: @escaping (Result<VerifyOTPResponseModel, Error>) -> Void)
}
