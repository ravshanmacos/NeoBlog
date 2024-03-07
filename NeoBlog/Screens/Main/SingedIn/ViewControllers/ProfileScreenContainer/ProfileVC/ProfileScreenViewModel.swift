//
//  ProfileScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation
import Combine

enum ProfileScreenState {
    case initial
    case tableviewIsEmpty
    case tableviewNotEmpty
}

class ProfileScreenViewModel: EmptyPostViewModel {

    //MARK: Properties
    @Published private(set) var optionsData: [OptionModel] = []
    private(set) var posts: [BlogPost] = []
    
    
    @Published private(set) var openCreatePostCollectionSheet = false
    @Published private(set) var viewState: ProfileScreenState = .tableviewIsEmpty
    
    private let userProfile: UserProfile
    private let postRepository: PostRepository
    private let goToEditProfileSheetNavigator: GoToEditProfileSheetNavigator
    
    //MARK: Methods
    init(goToEditProfileSheetNavigator: GoToEditProfileSheetNavigator,
         postRepository: PostRepository, userProfile: UserProfile) {
        self.goToEditProfileSheetNavigator = goToEditProfileSheetNavigator
        self.postRepository = postRepository
        self.userProfile = userProfile
        getOptionsData()
    }
    
    func getUsername() -> String {
        guard let username = userProfile.username else { return "User" }
        return username
    }
    
    func createPostTapped() {
        
    }
    
    func setTableviewState() {
        viewState = posts.isEmpty ? .tableviewIsEmpty : .tableviewNotEmpty
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

//MARK: Networking
extension ProfileScreenViewModel {
    func getMyPosts() {
        postRepository
            .getMyPosts()
            .done { posts in
                self.posts = posts
                self.setTableviewState()
            }.catch { error in
                print(error)
            }
    }
}
