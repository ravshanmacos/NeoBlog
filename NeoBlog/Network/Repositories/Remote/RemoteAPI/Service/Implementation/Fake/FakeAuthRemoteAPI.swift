//
//  FakeAuthRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

class FakeAuthRemoteAPI: AuthRemoteAPI {
    func changePassword(token: String, requestModel: ChangeForgotPasswordRequestModel, callback: @escaping (Result<GeneralResponse, Error>) -> Void) {
        
    }
    
    func verifyOTP(requestModel: VerifyOTPRequestModel, callback: @escaping (Result<VerifyOTPResponseModel, Error>) -> Void) {
        
    }
    
    func forgotPassword(requestModel: SendOTPRequestModel, callback: @escaping (Result<GeneralResponse, Error>) -> Void) {
        
    }
    
    func signUp(requestModel: SignUpRequestModel, callback: @escaping (Result<SignUpResponseModel, Error>) -> Void) {
        
    }
    
    func sigIn(requestModel signInRequest: SignInRequestModel, callback: @escaping (Result<SignInResponseModel, Error>) -> Void) {
        print("Fake api sign in requeest")
    }
}
