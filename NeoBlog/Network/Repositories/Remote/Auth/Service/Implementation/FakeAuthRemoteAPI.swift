//
//  FakeAuthRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

class FakeAuthRemoteAPI: AuthRemoteAPI {
    func sigIn(requestModel signInRequest: SignInRequestModel, callback: @escaping (Result<SignInResponseModel, Error>) -> Void) {
        print("Fake api sign in requeest")
    }
}
