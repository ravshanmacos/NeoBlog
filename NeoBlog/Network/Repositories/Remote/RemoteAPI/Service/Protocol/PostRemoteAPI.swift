//
//  PostRemoteAPI.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation

protocol PostRemoteAPI {
    //Get Categories List
    func getCategoriesList(callback: @escaping (Result<[Category], Error>) -> Void)
    
    //Get My Posts
    func getMyPosts(callback: @escaping (Result<[BlogPost], Error>) -> Void)
    
    //Get Post Details
    func getPostDetail(postID: Int, callback: @escaping (Result<BlogPost, Error>) -> Void)
    
    //Get Uset Collections
    func getUserCollections(userID: Int, callback: @escaping (Result<[Collection], Error>) -> Void)
    
    //Get Posts
    func getBlogPost(categoryName: String, query: String, startDate: String, endDate: String, callback: @escaping (Result<[BlogPost], Error>) -> Void)
    
    
    
    //Save Post To Collection
    func addPostToCollection(requestModel: AddPostToCollectionRequestModel, collectionID: Int, callback: @escaping (Result<GeneralResponse, Error>) -> Void)
    
    //Create Collection
    func createCollection(authorID: Int, requestModel: CreateCollection, callback: @escaping (Result<CreateCollection, Error>) -> Void)
    
    //Create Comment
    func createComment(requestModel: CreateCommentRequestModel, callback: @escaping (Result<CreateCommentRequestModel, Error>) -> Void)
    
    //Create Post
    func createPost(requestModel: CreateAndUpdatePostRequestModel, callback: @escaping (Result<CreateAndUpdatePostRequestModel, Error>) -> Void)
    
    //Update Collection
    func updateCollection(collectionID: Int, requestModel: UpdateCollectionRequestModel, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
    
    //Update Post
    func updatePost(postID: Int, requestModel: CreateAndUpdatePostRequestModel, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
    
    //Delete
    func deleteCollection(collectionID: Int, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
    
    func deletePost(postID: Int, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
}
