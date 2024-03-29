//
//  PostRepository.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation
import PromiseKit

protocol PostRepository {
    //MARK: Get
    
    //Get My Posts
    func getMyPosts() -> Promise<[BlogPost]>
    
    //Get Collection Posts
    func getCollecitonPosts(collectionID: Int) -> Promise<[BlogPost]>
    
    // Get Categories List
    func getCategoriesList() -> Promise<[Category]>
    
    //Get Post Details
    func getPostDetail(postID: Int) -> Promise<BlogPost>
    
    //Get User Collections
    func getUserCollections(userID: Int) -> Promise<[Collection]>
    
    //Get Posts List
    func getBlogPostList(categoryName: String, query: String, startDate: String, endDate: String, period: String) -> Promise<[BlogPost]>
    
    //MARK: POST
    
    //Create Collection
    func createCollection(authorID: Int, requestModel: CreateCollection) -> Promise<CreateCollection>
    
    //Create Comment
    func createComment(requestModel: CreateCommentRequestModel) -> Promise<CreateCommentRequestModel>
    
    //Create Post
    func createPost(parameters: [String: Any]) -> Promise<CreateAndUpdatePostRequestModel>
    
    //AddPostToCollection
    func addPostToCollection(collectionID: Int, requestModel: AddPostToCollectionRequestModel) -> Promise<GeneralResponse>
    
    //MARK: UPDATE
    
    //Update Post
    func updatePost(postID: Int, parameters: [String: Any]) -> Promise<CreateAndUpdatePostRequestModel>
    
    //Update Password
    func updatePassword(requestModel: UpdatePasswordRequestModel) -> Promise<GeneralResponse>
    
    //Update Login And Email
    func updateLoginAndEmail(requestModel: UpdateLoginAndEmailRequestModel) -> Promise<GeneralResponse>
    
    //Update Collection
    func updateCollection(collectionID: Int, requestModel: UpdateCollectionRequestModel) -> Promise<Collection>
    
    //MARK: Delete
    
    //Delete Collection
    func deleteCollection(collectionID: Int) -> Promise<String>
    
    //Delete Post
    func deletePost(postID: Int) -> Promise<String>
}
