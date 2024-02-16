//
//  LaunchViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class LaunchViewModel {
    
    //MARK: Properties
    private let notSignedInResponder: NotSignedInResponder
    private let signedInResponder: SignedInResponder
    
    //MARK: Methods
    init(notSignedInResponder: NotSignedInResponder, signedInResponder: SignedInResponder) {
        self.notSignedInResponder = notSignedInResponder
        self.signedInResponder = signedInResponder
    }
    
    func loadUserSession() {
        notSignedInResponder.notSignedIn()
    }
}
