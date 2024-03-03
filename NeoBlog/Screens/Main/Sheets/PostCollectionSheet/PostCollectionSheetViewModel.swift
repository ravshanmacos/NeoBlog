//
//  PostCollectionSheetViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 25/02/24.
//

import Foundation
import Combine

class PostCollectionSheetViewModel {
    
    //MARK: Properties
    @Published private(set) var openCreatePostCollectionSheet = false
    @Published private(set) var collections: [Collection] = []
    
    private let postRepository: PostRepository
    private let userProfile: UserProfile
    
    //MARK: Methods
    init(postRepository: PostRepository, userProfile: UserProfile) {
        self.postRepository = postRepository
        self.userProfile = userProfile
    }
    
    func getOptionsData(){
        guard let id = userProfile.id else { return }
        postRepository
            .getUserCollections(userID: id)
            .done({ collections in
                self.collections = collections
            })
            .catch { error in
                print(error)
            }
    }
    
    func unSelectAllOptions() {
//        for index in 0..<collections.count {
//            collections[index].isActive = false
//        }
    }
    
    func activateOption(for index: Int) {
        //optionsData[index].isActive = true
    }
    
    func addNewCollection(name: String) {
        guard let id = userProfile.id else { return }
        let requestModel = CreateCollection(name: name)
        postRepository
            .createCollection(authorID: id, requestModel: requestModel)
            .done { name in
                print("Successfully created \(name) collection")
                self.getOptionsData()
            }.catch { error in
                print(error)
            }
//        unSelectAllOptions()
//        let newOption = OptionModel(title: name, isActive: true)
//        optionsData.insert(newOption, at: 1)
    }
    
    @objc func addCollectionBtnTapped() {
        openCreatePostCollectionSheet = true
    }
}

/*
 //        optionsData = [
 //            .init(title: "Избранное", saveds: 289, isActive: true),
 //            .init(title: "Почитать потом", saveds: 14),
 //            .init(title: "Про айти", saveds: 8),
 //            .init(title: "Про книги", saveds: 189)
 //        ]
 */
