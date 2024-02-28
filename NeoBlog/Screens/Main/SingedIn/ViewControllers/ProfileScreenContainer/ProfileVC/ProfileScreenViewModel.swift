//
//  ProfileScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Combine

class ProfileScreenViewModel {
    
    //MARK: Properties
    @Published private(set) var optionsData: [OptionModel] = []
    
    @Published private(set) var openCreatePostCollectionSheet = false
    
    private let goToEditProfileSheetNavigator: GoToEditProfileSheetNavigator
    
    //MARK: Methods
    init(goToEditProfileSheetNavigator: GoToEditProfileSheetNavigator) {
        self.goToEditProfileSheetNavigator = goToEditProfileSheetNavigator
        getOptionsData()
    }
    
    func getOptionsData(){
        optionsData = [
            .init(title: "Избранное", saveds: 289, isActive: true),
            .init(title: "Почитать потом", saveds: 14),
            .init(title: "Про айти", saveds: 8),
            .init(title: "Про книги", saveds: 189)
        ]
    }
    
    func unSelectAllOptions() {
        for index in 0..<optionsData.count {
            optionsData[index].isActive = false
        }
    }
    
    func activateOption(for index: Int) {
        optionsData[index].isActive = true
    }
    
    func addNewCollection(name: String) {
        unSelectAllOptions()
        let newOption = OptionModel(title: name, isActive: true)
        optionsData.insert(newOption, at: 1)
    }
}

@objc extension ProfileScreenViewModel {
   func openEditProfileSheet() {
        goToEditProfileSheetNavigator.navigateToEditProfileSheet()
    }
    
    func addCollectionBtnTapped() {
        openCreatePostCollectionSheet = true
    }
}
