//
//  PostRepository.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 01/03/24.
//

import Foundation
import PromiseKit

/*
 protocol PostRemoteAPI {
     //Get
     func getMyPosts(callback: @escaping (Result<[BlogPost], Error>) -> Void)
     func getPostDetail(postID: Int, callback: @escaping (Result<BlogPost, Error>) -> Void)
     func getUserCollections(userID: Int, callback: @escaping (Result<[Collection], Error>) -> Void)
     func getBlogPost(categoryName: String, query: String, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
     
     //Post
     func savePostToCollection(requestModel: AddPostToCollectionRequestModel, collectionID: Int, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
     func createCollection(authorID: Int, requestModel: CreateCollectionRequestModel, callback: @escaping (Result<String, Error>) -> Void)
     func createComment(requestModel: CreateCommentRequestModel, callback: @escaping (Result<CreateCommentRequestModel, Error>) -> Void)
     func createPost(requestModel: CreateAndUpdatePostRequestModel, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
     
     //PUT
     func updateCollection(collectionID: Int, requestModel: UpdateCollectionRequestModel, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
     func updatePost(postID: Int, requestModel: CreateAndUpdatePostRequestModel, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
     
     //Delete
     func deleteCollection(collectionID: Int, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
     func deletePost(postID: Int, callback: @escaping (Result<BlogPostListResponseModel, Error>) -> Void)
 }
 */

protocol PostRepository {
    func getBlogPostList(categoryName: String, query: String) -> Promise<BlogPostListResponseModel>
    func getPostDetail(postID: Int) -> Promise<BlogPost>
    func getUserCollections(userID: Int) -> Promise<[Collection]>
    
    //Create Collection
    func createCollection(authorID: Int, requestModel: CreateCollection) -> Promise<CreateCollection>
    
    //Create Comment
    func createComment(requestModel: CreateCommentRequestModel) -> Promise<CreateCommentRequestModel>
}
