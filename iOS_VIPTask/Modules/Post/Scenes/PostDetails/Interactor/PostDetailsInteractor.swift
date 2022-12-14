//
//  PostInteractor.swift
//  iOS_VIPTask
//
//  Created by Fintech on 19/10/2022.
//

import Foundation

protocol PostDetailsInteractorProtocol {
    func getPostDetails(request: PostDetails.Request) async throws
}

class PostDetailsInteractor {
    let postService: PostsGateway
    let postPresenter: PostDetailsPresenterProtocol
    var postDetailsDataStore: PostDetailsDataStoreProtocol
    let postID: Int?
    
    init(postsService: PostsGateway,
         postPresenter: PostDetailsPresenterProtocol,
         postDetailsDataStore: PostDetailsDataStoreProtocol,
         postID: Int) {
        self.postService = postsService
        self.postPresenter = postPresenter
        self.postDetailsDataStore = postDetailsDataStore
        self.postID = postID
    }
}

extension PostDetailsInteractor: PostDetailsInteractorProtocol {

    func getPostDetails(request: PostDetails.Request) async throws {
        
        let entity = try await postService.throwingGetPostDetails(postID: (postID ?? 0) + 1)
        let fetchedId = entity.id
        self.postDetailsDataStore.postID = fetchedId
        self.postPresenter.presentPostDetails(postDetails: PostDetails.Response(postDetails: entity))

//        postService.getPostDetails(postID: (postID ?? 0) + 1) { [weak self] result in
//            switch result {
//            case .failure:
//                print("error post Details")
//            case .success(let res):
//                let fetchedId = res.id
//                self?.postDetailsDataStore.postID = fetchedId
//                self?.postPresenter.presentPostDetails(postDetails: PostDetails.Response(postDetails: res))
//            }
//        }
    }

}
