//
//  EditProfileViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 28/02/24.
//

import Foundation

class EditProfileViewModel {
    //MARK: Properties
    private let goToChangeLoginAndEmailNavigator: GoToChangeLoginAndEmailNavigator
    private let goToChangePasswordNavigator: GoToChangePasswordNavigator
    
    //MARK: Methods
    init(goToChangeLoginAndEmailNavigator: GoToChangeLoginAndEmailNavigator, goToChangePasswordNavigator: GoToChangePasswordNavigator) {
        self.goToChangeLoginAndEmailNavigator = goToChangeLoginAndEmailNavigator
        self.goToChangePasswordNavigator = goToChangePasswordNavigator
    }
    
    @objc func changeEmailAndLoginTapped() {
        print("changeEmailAndLoginTapped")
        goToChangeLoginAndEmailNavigator.navigateToChangeLoginAndEmail()
    }
    
    @objc func changePasswordTapped() {
        print("changePasswordTapped")
        goToChangePasswordNavigator.navigateToChangePassowrd()
    }
}
