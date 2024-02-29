//
//  UserSessionRepository.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import PromiseKit

protocol UserSessionRepository {
    func readUserSession() -> Promise<UserSession?>
    func forgotPassword(reqeustModel: SendOTPRequestModel) -> Promise<GeneralResponse>
    func verifyOTP(reqeustModel: VerifyOTPRequestModel) -> Promise<UserSession>
    
    func signUp(requestModel: SignUpRequestModel) -> Promise<Message>
    func signIn(requestModel: SignInRequestModel) -> Promise<UserSession>
    func signOut(userSession: UserSession) -> Promise<UserSession>
}
