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
    @Published private(set) var categories: [Category] = []
    
    @Published private(set) var clearForm = false
    @Published private(set) var publishBtnEnabled = false
    @Published private(set) var loadingIndicatorEnabled = false
    @Published private(set) var dissmissView = false
    
    var heading: String = "" { didSet { checkForm() } }
    var selectedCategory: Int? = nil {didSet { checkForm() } }
    var description: String = "" { didSet { checkForm() } }
    var imageData: Data? = nil { didSet { checkForm() } }
    
    private let postRepository: PostRepository
    private let userProfile: UserProfile
    
    var postID: Int?
    
    //MARK: Methods
    
    init(postRepository: PostRepository, userProfile: UserProfile) {
        self.postRepository = postRepository
        self.userProfile = userProfile
    }
    
    func getCategories(_ completion: @escaping (() -> Void)) {
        postRepository
            .getCategoriesList()
            .done({ categories in
                self.categories = categories
                self.categories[0].active = true
                self.selectedCategory = self.categories[0].id
                completion()
            })
            .catch { error in
                print(error)
            }
    }
    
    func setDefaultSelectedCategory() {
        activateCategorFor(index: 0)
    }
    
    func activateCategoryFor(id: Int?) {
        for number in 0..<categories.count {
            if categories[number].id == id {
                print("Category was found, and it is \(categories[number])")
                categories[number].active = true
            } else {
                categories[number].active = false
            }
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
        loadingIndicatorEnabled = true
        postRepository
            .createPost(parameters: parameters)
            .done { response in
                print(response)
                self.clearForm = true
                self.loadingIndicatorEnabled = false
                self.closeBtnTapped()
            }.catch { error in
                print(error)
                self.loadingIndicatorEnabled = false
            }
    }
    
    @objc func updatePostBtnTapped() {
        guard let authorID = userProfile.id, let postID, let selectedCategory, let imageData else { return }
        let parameters: [String: Any] = [
            "title": heading,
            "description": description,
            "photo": imageData,
            "author": authorID,
            "category": selectedCategory
        ]
        postRepository
            .updatePost(postID: postID, parameters: parameters)
            .done { response in
                print(response)
                self.dissmissView = true
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
