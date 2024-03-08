//
//  CollectionPostsRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 08/03/24.
//

import UIKit
import Combine
import SnapKit

class CollectionPostsRootView: BaseView {
    
    //MARK: Properties
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: CollectionPostsViewModel
    private let wrapperView = UIStackView()
    private var postsTableView: UITableView?
    private var emptyView: EmptyView?
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: CollectionPostsViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindings()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(wrapperView)
        wrapperView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func bindings() {
        viewModel
            .$viewState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] viewState in
                guard let self else { return }
                switch viewState {
                case .initial: print("Initial")
                case .postsEmpty: presentPostsEmtpyState()
                case .postsNotEmpty: presentPostsNotEmtpyState()
                }
            }.store(in: &subscriptions)
    }
    
    private func presentPostsEmtpyState() {
        self.wrapperView.removeSubviews()
        self.postsTableView = nil
        
        self.emptyView = makeEmptyView()
        self.wrapperView.addArrangedSubviews(emptyView!)
    }
    
    private func presentPostsNotEmtpyState() {
        self.wrapperView.removeSubviews()
        self.emptyView = nil
        
        self.postsTableView = makeTableview()
        self.postsTableView!.dataSource = self
        self.postsTableView!.delegate = self
        self.wrapperView.addArrangedSubviews(postsTableView!)
    }
    
    private func makeTableview() -> UITableView {
        let tableview = UITableView()
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        PostsTableviewCell.register(to: tableview)
        return tableview
    }
    
    private func makeEmptyView() -> EmptyView {
        let emptyView = EmptyView()
        emptyView.titleLabel.text = "Еще нет постов"
        emptyView.descriptionLabel.text = "Здесь будут показаны посты, добавленные в данную подборку"
        return emptyView
    }
}

extension CollectionPostsRootView: PostsTableviewCellDelegate {
    func savePost(collectionID: Int?, postID: Int, _ saved: ((Bool) -> Void)) {
        //viewModel.openPostCollectionSheet(collectionID: collectionID, postID: postID)
        //saved(true)
    }
}

extension CollectionPostsRootView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = PostsTableviewCell.deque(on: tableView, at: indexPath) else { return UITableViewCell() }
        let post = viewModel.posts[indexPath.item]
        cell.delegate = self
        if let collectionInfo = post.collectionInfo, collectionInfo.count > 0 {
            cell.setCollectionID(collectionID: post.collectionInfo?[0].id)
        }
        cell.setPostID(postID: post.id)
        cell.setUsername(with: post.author?.username)
        cell.setCreated(at: post.publicationDate)
        cell.setCommentsCount(with: post.commentsCount)
        cell.setCategoryLabel(with: post.category.name)
        cell.setTitle(with: post.title)
        cell.setSubtitle(wtih: post.description)
        cell.setImage(urlString: post.photo)
        cell.IsPostInCollection(saved: post.inCollections ?? false)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.item]
        guard let id = post.id else { print("Post id not found"); return }
        //viewModel.navigateToPostDetails(with: id)
    }
}

