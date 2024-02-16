//
//  MainViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

class MainViewModel: SignedInResponder, NotSignedInResponder {
    
    //MARK: Properties
    @Published private(set) var view: MainViewState = .launching
    
    //MARK: Methods
    func notSignedIn() {
        view = .onboarding
    }
    
    func signedIn() {
        view = .signedIn
    }
}
