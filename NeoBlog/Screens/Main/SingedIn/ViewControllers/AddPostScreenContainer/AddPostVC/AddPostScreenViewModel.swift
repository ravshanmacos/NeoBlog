//
//  AddPostScreenViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import Foundation

class AddPostScreenViewModel {
    
    //MARK: Properties
    @Published private(set) var addPostScreenState: AddPostScreenState?
    @Published private(set) var publishBtnEnabled = false
    @Published private(set) var categories: [Category] = []
    
    var heading: String = "" {didSet { checkForm() } }
    var selectedCategory: Int? = nil {didSet { checkForm() } }
    var description: String = "" {didSet { checkForm() } }
    var imageData: Data? = nil {didSet { checkForm() } }
    
    private let postRepository: PostRepository
    private let userProfile: UserProfile
    
    //MARK: Methods
    
    init(postRepository: PostRepository, userProfile: UserProfile) {
        self.postRepository = postRepository
        self.userProfile = userProfile
        getCategories()
    }
    
    private func getCategories() {
        postRepository
            .getCategoriesList()
            .done({ categories in
                self.categories = categories
                self.categories[0].active = true
                self.selectedCategory = self.categories[0].id
            })
            .catch { error in
                print(error)
            }
    }
    
    func activateCategorFor(index: Int) {
        for number in 0..<categories.count {
            categories[number].active = false
        }
        
        categories[index].active = true
        selectedCategory = categories[index].id
    }
    
    @objc func publishPostBtnTapped() {
        guard let authorID = userProfile.id, let selectedCategory, let imageData else { return }
        let parameters: [String: Any] = [
            "title": heading,
            "description": description,
            "photo": imageData,
            "author": authorID,
            "category": selectedCategory
        ]
        postRepository
            .createPost(parameters: parameters)
            .done { response in
                print(response)
            }.catch { error in
                print(error)
            }
    }
    
    @objc func closeBtnTapped() {
        addPostScreenState = .closeVC
    }
    
    func chooseFromLibrary() {
        addPostScreenState = .chooseFromLibrary
    }
   
    func takePhotoOrVideo() {
        addPostScreenState = .takePhotoOrVideo
    }
    
    func chooseFile() {
        addPostScreenState = .chooseFile
    }
    
    private func checkForm() {
        guard heading != "" &&
              selectedCategory != nil &&
              description != "" &&
              imageData != nil
        else {
            publishBtnEnabled = false
            return
        }
        publishBtnEnabled = true
    }
}
