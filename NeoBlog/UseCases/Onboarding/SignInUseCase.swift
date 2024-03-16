//
//  SignInUseCase.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 16/03/24.
//

import Foundation
//import PromiseKit

typealias SignInUseCaseResult = Result<Void, ErrorMessage>

class SignInUseCase: UserCase {
    
    //MARK: Properties
    
    //Input Data
    private let email: String
    private let password: String
    
    //Side-effect Subsystems
    private let remoteAPI: AuthRemoteAPI
    private let dataStore: UserSessionDataStore
    
    //Progress Closures
    private let onStart: () -> Void
    private let onComplete: (SignInUseCaseResult) -> Void
    
    //MARK: Methods
    
    init(email: String, password: String,
         remoteAPI: AuthRemoteAPI, dataStore: UserSessionDataStore,
         onStart: (() -> Void)? = nil,
         onComplete: ((SignInUseCaseResult) -> Void)? = nil){
        self.email = email
        self.password = password
        self.remoteAPI = remoteAPI
        self.dataStore = dataStore
        self.onStart = onStart ?? {}
        self.onComplete = onComplete ?? { result in }
    }
    
    func start() {
        assert(Thread.isMainThread)
        onStart()
    }
}
