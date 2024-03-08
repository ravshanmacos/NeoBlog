//
//  ProfileScreenRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit
import Combine

class ProfileScreenRootView: BaseView {
    
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let usernameLabel = makeUsernameLabel()
    
    private let menuBtn = makeMenuButton()
    private let segmentedView = makeCustomSegmentedView()
    private let viewWrapper = UIStackView()
    private let headerHStack = makeHeaderHStack()
    
    private var postsTableView: UITableView?
    private var collectionsTableView: UITableView?
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: ProfileScreenViewModel
    var userID: Int?
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: ProfileScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindings()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(headerHStack, usernameLabel, segmentedView, viewWrapper)
        headerHStack.addArrangedSubviews(titleLabel, menuBtn)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerHStack.snp.makeConstraints{ $0.top.leading.trailing.equalToSuperview() }
        menuBtn.snp.makeConstraints { $0.width.height.equalTo(40) }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(headerHStack.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        segmentedView.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        viewWrapper.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setUserName(text: String) {
        usernameLabel.text = text
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        segmentedView.delegate = self
        viewModel.setTableviewState()
        menuBtn.addTarget(viewModel, action: #selector(viewModel.openEditProfileSheet), for: .touchUpInside)
    }
    
    private func setCollectionsTableView() {
        viewWrapper.removeSubviews()
        self.postsTableView = nil
        
        self.collectionsTableView = makeCollectionTableView()
        self.collectionsTableView!.delegate = self
        self.collectionsTableView!.dataSource = self
        viewWrapper.addArrangedSubview(collectionsTableView!)
    }
}

//MARK: CustomSegmentViewDelegate, PostsTableviewCellDelegate
extension ProfileScreenRootView: CustomSegmentViewDelegate, PostsTableviewCellDelegate {
    func savePost(collectionID: Int?, postID: Int, _ saved: ((Bool) -> Void)) {
        
    }
    
    func myPostsTapped() {
        viewModel.getMyPosts()
        viewModel.setTableviewState()
    }
    
    func collectionsTapped() {
        setCollectionsTableView()
        viewModel.getCollections()
    }
    
    func savePost(_ saved: ((Bool) -> Void)) {
        
    }
}

//MARK: UITableViewDataSource
extension ProfileScreenRootView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == postsTableView {
            return viewModel.posts.count
        } else {
            return viewModel.collections.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == postsTableView {
            return myPostsTableView(tableView, cellForRowAt: indexPath)
        } else {
            return collectionsTableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func myPostsTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = PostsTableviewCell.deque(on: tableView, at: indexPath) else { return UITableViewCell() }
        let post = viewModel.posts[indexPath.row]
        cell.delegate = self
        cell.setUsername(with: post.author?.username)
        cell.setCreated(at: post.publicationDate)
        cell.setCommentsCount(with: post.commentsCount)
        cell.setCategoryLabel(with: post.category.name)
        cell.setTitle(with: post.title)
        cell.setSubtitle(wtih: post.description)
        cell.setImage(urlString: post.photo)
        cell.selectionStyle = .none
        return cell
    }
    
    private func collectionsTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath)
        let item = viewModel.collections[indexPath.item]
        let count = item.postCount == nil ? 0 : item.postCount!
        var config = cell.defaultContentConfiguration()
        config.text = item.name
        config.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        config.secondaryText = "Сохранено: \(count)"
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
 
//MARK: UITableViewDelegate
extension ProfileScreenRootView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView == collectionsTableView ? makeAddCollectionButton() : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == collectionsTableView ? 50 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == collectionsTableView {
            viewModel.collectionItemTapped(for: indexPath.item)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

//MARK: Bindings
extension ProfileScreenRootView {
    private func bindings() {
        viewModel
            .$collections
            .receive(on: DispatchQueue.main)
            .sink {[weak self] collections in
                guard let self else { return }
                collectionsTableView?.reloadData()
            }.store(in: &subscriptions)
        
        viewModel
            .$viewState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] viewState in
                guard let self else { return }
                switch viewState {
                case .initial: print("Initial")
                case .tableviewIsEmpty: presentEmptyTableviewState()
                case .tableviewNotEmpty: presentNotEmptyTableviewState()
                }
            }.store(in: &subscriptions)
    }
}

//MARK: States
private extension ProfileScreenRootView {
    func presentEmptyTableviewState() {
        viewWrapper.removeSubviews()
        self.postsTableView = nil
        self.collectionsTableView = nil
        
        let emptyPostView = EmptyPostsView(viewModel: viewModel)
        viewWrapper.addArrangedSubview(emptyPostView)
    }
    
    func presentNotEmptyTableviewState() {
        viewWrapper.removeSubviews()
        self.collectionsTableView = nil
        
        self.postsTableView = MainScreenRootView.makePostsTableView()
        self.postsTableView!.delegate = self
        self.postsTableView!.dataSource = self
        viewWrapper.addArrangedSubview(postsTableView!)
    }
}

