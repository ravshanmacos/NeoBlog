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
    private let selectCategorySegmentView = makeSelectCategorySegmentView()
    private let postsTableView = makePostsTableView()
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: MainScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        viewModel
            .$blogPostList
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let self else { return }
                postsTableView.reloadData()
            }.store(in: &subscriptions)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerView, selectCategorySegmentView, postsTableView)
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
        
        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(selectCategorySegmentView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        selectCategorySegmentView.delegate = self
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
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

extension MainScreenRootView: PostsTableviewCellDelegate, SelectCatergorySegmentViewDelegate {
    func savePost(collectionID: Int?, postID: Int, _ saved: ((Bool) -> Void)) {
        viewModel.openPostCollectionSheet(collectionID: collectionID, postID: postID)
        saved(true)
    }
    
    func categoryDidSelected(item: CategoryItem) {
        viewModel.filterByCategory(item: item)
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

