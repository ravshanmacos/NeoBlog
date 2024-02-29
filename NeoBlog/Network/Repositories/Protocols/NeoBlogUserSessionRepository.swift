//
//  NeoBlogUserSessionRepository.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 29/02/24.
//

import Foundation
import PromiseKit

class NeoBlogUserSessionRepository: UserSessionRepository {
    //MARK: Properties
    private let dataStore: UserSessionDataStore
    private let remoteAPI: AuthRemoteAPI
    
    init(dataStore: UserSessionDataStore, remoteAPI: AuthRemoteAPI) {
        self.dataStore = dataStore
        self.remoteAPI = remoteAPI
    }
    
    
    //MARK: Methods
    func readUserSession() -> Promise<UserSession?> {
        return dataStore.readUserSession()
    }
    
    func forgotPassword(reqeustModel: SendOTPRequestModel) -> Promise<GeneralResponse> {
        return Promise<GeneralResponse> { resolver in
            remoteAPI.forgotPassword(requestModel: reqeustModel) { result in
                switch result {
                case .success(let response):
                    resolver.fulfill(response)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func verifyOTP(reqeustModel: VerifyOTPRequestModel) -> Promise<UserSession> {
        return Promise<UserSession> { resolver in
            remoteAPI.verifyOTP(requestModel: reqeustModel) { result in
                switch result {
                case .success(let response):
                    let remoteSession = RemoteUserSession(accessToken: response.access, refreshToken: response.refresh)
                    let userSession = UserSession(remoteSession: remoteSession)
                    resolver.fulfill(userSession)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func signIn(requestModel: SignInRequestModel) -> Promise<UserSession> {
        return Promise<UserSession> { resolver in
            remoteAPI.sigIn(requestModel: requestModel) { result in
                switch result {
                case .success(let response):
                    let remoteSession = RemoteUserSession(accessToken: response.access, refreshToken: response.refresh)
                    let userSession = UserSession(remoteSession: remoteSession)
                    resolver.fulfill(userSession)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }.then(dataStore.save(userSession:))
    }
    
    func signUp(requestModel: SignUpRequestModel) -> Promise<Message> {
        return Promise<Message> { resolver in
            remoteAPI.signUp(requestModel: requestModel) { result in
                switch result {
                case .success(let response):
                    resolver.fulfill(response.message)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func signOut(userSession: UserSession) -> Promise<UserSession> {
        return dataStore.delete(userSession: userSession)
    }
}
