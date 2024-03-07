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
    
    override func configureAppearance() {
        super.configureAppearance()
        usernameLabel.text = viewModel.getUsername()
        segmentedView.delegate = self
        viewModel.setTableviewState()
        menuBtn.addTarget(viewModel, action: #selector(viewModel.openEditProfileSheet), for: .touchUpInside)
    }
    
    private func setCollectionsTableView() {
        viewWrapper.removeSubviews()
        self.postsTableView = nil
        
        self.collectionsTableView = PostCollectionRootView.makeTableView()
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
        print("My Post Tapped")
        viewModel.setTableviewState()
    }
    
    func collectionsTapped() {
        print("Collections Tapped")
        setCollectionsTableView()
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
            return viewModel.optionsData.count
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
        guard let cell = OptionViewTableViewCell.deque(on: tableView, at: indexPath) else { return UITableViewCell() }
        let item = viewModel.optionsData[indexPath.item]
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.getSavedDescriptions()
        cell.radioButton.isSelected = item.isActive
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
        
        if tableView == postsTableView {
            //viewModel.navigateToPostDetails(with: indexPath.item)
        } else {
            viewModel.unSelectAllOptions()
            viewModel.activateOption(for: indexPath.item)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

//MARK: Bindings
extension ProfileScreenRootView {
    private func bindings() {
        viewModel
            .$optionsData
            .receive(on: DispatchQueue.main)
            .sink {[weak self] optionsdata in
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

