//
//  MainScreenRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit
import Combine

class MainScreenRootView: BaseView {
    
    //MARK: Properties
    private let headerView = makeHeader()
    private let selectCategorySegmentView: SelectCatergorySegmentView
    private let wrapperView = UIStackView()
    private var postsTableView: UITableView?
    private var emptyView: EmptyView?
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: MainScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        self.selectCategorySegmentView = SelectCatergorySegmentView(viewModel: viewModel)
        super.init(frame: frame)
        bindings()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerView, selectCategorySegmentView, wrapperView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        selectCategorySegmentView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(60)
        }
        
        wrapperView.snp.makeConstraints { make in
            make.top.equalTo(selectCategorySegmentView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        headerView.searchBarWithFilter.searchTextField.delegate = self
        headerView.searchBarWithFilter.leftButtonClicked = searchButtonClicked
        headerView.searchBarWithFilter.rightButtonClicked = filterButtonClicked
    }
    
    private func searchButtonClicked () {
        viewModel.search(with: headerView.searchBarWithFilter.searchTextField.text)
    }
    
    private func filterButtonClicked () {
        viewModel.openFilterByDate()
    }
    
    private func presentPostsEmtpyState() {
        self.wrapperView.removeSubviews()
        self.postsTableView = nil
        
        if let selectedCategory = viewModel.selectedCategory {
            self.emptyView = makeEmptyView(subtitle: "Здесь будут показаны посты из категории “\(selectedCategory)” ")
        } else {
                self.emptyView = makeEmptyView()
        }
        
        self.wrapperView.addArrangedSubviews(emptyView!)
    }
    
    private func presentPostsNotEmtpyState() {
        self.wrapperView.removeSubviews()
        self.emptyView = nil
        
        self.postsTableView = makePostsTableView()
        self.postsTableView!.dataSource = self
        self.postsTableView!.delegate = self
        self.wrapperView.addArrangedSubviews(postsTableView!)
    }
    
}

extension MainScreenRootView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.search(with: textField.text)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.search(with: textField.text)
    }
}

extension MainScreenRootView: PostsTableviewCellDelegate {
    func savePost(collectionID: Int?, postID: Int, _ saved: ((Bool) -> Void)) {
        viewModel.openPostCollectionSheet(collectionID: collectionID, postID: postID)
        saved(true)
    }
}

extension MainScreenRootView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.blogPostList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = PostsTableviewCell.deque(on: tableView, at: indexPath) else { return UITableViewCell() }
        let post = viewModel.blogPostList[indexPath.item]
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
        let post = viewModel.blogPostList[indexPath.item]
        guard let id = post.id else { print("Post id not found"); return }
        viewModel.navigateToPostDetails(with: id)
    }
}

extension MainScreenRootView {
    private func bindings() {
        viewModel
            .$blogPostList
            .receive(on: DispatchQueue.main)
            .sink {[weak self] posts in
                guard let self else { return }
                posts.isEmpty ? presentPostsEmtpyState() : presentPostsNotEmtpyState()
            }.store(in: &subscriptions)
    }
}
