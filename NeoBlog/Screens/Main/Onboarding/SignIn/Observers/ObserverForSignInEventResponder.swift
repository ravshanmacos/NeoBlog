//
//  ObserverForSignInEventResponder.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 13/03/24.
//

import Foundation

protocol ObserverForSignInEventResponder: AnyObject {
    func recieved(newErrorMessage errorMessage: ErrorMessage)
    func recieved(newViewState viewState: SignInViewState)
    func keyboardWillHide()
    func keyboardWillChangeFrame(keyboardEndFrame: CGRect)
}
