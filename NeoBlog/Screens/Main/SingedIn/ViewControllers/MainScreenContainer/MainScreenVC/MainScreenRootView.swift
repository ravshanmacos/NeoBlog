//
//  MainScreenRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

class MainScreenRootView: BaseView {
    
    //MARK: Properties
    private let headerView = makeHeader()
    private let selectCategorySegmentView = makeSelectCategorySegmentView()
    private let postsTableView = makePostsTableView()
    
    private let viewModel: MainScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
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
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        headerView.searchBarWithFilter.leftButtonClicked = leftButtonClicked
        headerView.searchBarWithFilter.rightButtonClicked = rightButtonClicked
    }
    
    func leftButtonClicked () {
        print("Search Clicked")
    }
    
    func rightButtonClicked () {
        print("Filter Clicked")
    }
}

extension MainScreenRootView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = PostsTableviewCell.deque(on: tableView, at: indexPath) else { return UITableViewCell() }
        cell.setUsername(with: "yamahaman")
        cell.setCreated(at: "14 дек в 21:00")
        cell.setCommentsCount(with: "2")
        cell.setCategoryLabel(with: "Искусство")
        cell.setTitle(with: Strings.titleLabel.rawValue)
        cell.setSubtitle(wtih: Strings.subtitleLabel.rawValue)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToPostDetails(with: indexPath.item)
    }
}

