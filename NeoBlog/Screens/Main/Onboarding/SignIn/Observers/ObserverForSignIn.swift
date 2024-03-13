//
//  ObserverForSignIn.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 13/03/24.
//

import Foundation
import Combine
import UIKit

class ObserverForSignIn: Observer {
    
    //MARK: Properties
    weak var eventResponder: ObserverForSignInEventResponder? {
        willSet {
            if newValue == nil {
                stopObserving()
            }
        }
    }
    
    let signInState: AnyPublisher<SignInViewControllerState, Never>
    var errorStateSubscription: AnyCancellable?
    var viewStateSubscription: AnyCancellable?
    
    private var isObserving: Bool {
        if isObservingState && isObservingKeyboard {
            return true
        } else {
            return false
        }
    }
    
    private var isObservingState: Bool {
        if errorStateSubscription != nil &&
            viewStateSubscription != nil {
            return true
        } else {
            return false
        }
    }
    
    private var isObservingKeyboard = false
    
    //MARK: Methods
    
    init(signInState: AnyPublisher<SignInViewControllerState, Never>) {
        self.signInState = signInState
    }
    
    func startObserving() {
        assert(self.eventResponder != nil)
        guard let _ = self.eventResponder else { return }
        if isObserving { return }
        
        subscribeToErrorMessages()
        subscribeToSignInState()
        startObservingKeyboardNotifications()
    }
    
    func stopObserving() {
        unsubscribeFromSignInViewState()
        unsubscribeFromErrorMessage()
        stopObservingNotificationCenterNotifications()
    }
    
    //Sign In State
    
    func subscribeToSignInState() {
        viewStateSubscription =
        signInState
            .receive(on: DispatchQueue.main)
            .map { $0.viewState }
            .removeDuplicates()
            .sink{[weak self] viewState in
                guard let self else { return }
                self.recieved(newViewState: viewState)
            }
    }
    
    func recieved(newViewState: SignInViewState) {
        eventResponder?.recieved(newViewState: newViewState)
    }
    
    func unsubscribeFromSignInViewState() {
        viewStateSubscription = nil
    }
    
    //Error Messages
    
    func subscribeToErrorMessages() {
        errorStateSubscription =
        signInState
            .receive(on: DispatchQueue.main)
            .map { $0.errorsToPresent.first }
            .compactMap { $0 }
            .removeDuplicates()
            .sink{[weak self] errorMessage in
                guard let self else { return }
                self.recieved(newErrorMessage: errorMessage)
            }
    }
    
    func recieved(newErrorMessage errorMessage: ErrorMessage) {
        self.eventResponder?.recieved(newErrorMessage: errorMessage)
    }
    
    func unsubscribeFromErrorMessage() {
        errorStateSubscription = nil
    }
    
    // Keyboard
    
    func startObservingKeyboardNotifications(){
        let notificationCenter = NotificationCenter.default
        
        notificationCenter
            .addObserver(self, selector: #selector(handle(keyboardWillHideNotification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        notificationCenter
            .addObserver(self, selector: #selector(handle(keyboardWillChangeFrameNotification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        isObservingKeyboard = true
    }
    
    @objc func handle(keyboardWillHideNotification notification: Notification) {
        assert(notification.name == UIResponder.keyboardWillHideNotification)
        eventResponder?.keyboardWillHide()
    }
    
    @objc func handle(keyboardWillChangeFrameNotification notification: Notification) {
        assert(notification.name == UIResponder.keyboardWillChangeFrameNotification)
        
        guard let userInfo = notification.userInfo
        else { return }
        
        guard let keyboardEndFrameUserInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
        else { return }
        
        guard let keyboardEndFrame = keyboardEndFrameUserInfo as? NSValue
        else { return }
        
        eventResponder?.keyboardWillChangeFrame(keyboardEndFrame: keyboardEndFrame.cgRectValue)
    }
    
    
    func stopObservingNotificationCenterNotifications(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
        
        isObservingKeyboard = false
    }
}
