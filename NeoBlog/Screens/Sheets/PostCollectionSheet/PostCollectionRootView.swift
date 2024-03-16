//
//  PostCollectionRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 25/02/24.
//

import UIKit
import Combine

class PostCollectionRootView: BaseView {
    //MARK: Properties
    private let titleLabel = makeTitleLabel()
    private let addPostCollectionBtn = makeAddCollectionButton()
    private let hStack = makeHStack()
    
    private let tableview = makeTableView()
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: PostCollectionSheetViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: PostCollectionSheetViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        observeOptionsData()
    }
    
    private func observeOptionsData() {
        viewModel
            .$collections
            .receive(on: DispatchQueue.main)
            .sink {[weak self] collections in
                guard let self else { return }
                self.tableview.snp.remakeConstraints { make in
                    make.top.equalTo(self.hStack.snp.bottom)
                    make.leading.equalToSuperview().offset(10)
                    make.trailing.equalToSuperview()
                    make.height.equalTo(collections.count * 70)
                }
                self.tableview.reloadData()
            }.store(in: &subscriptions)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(hStack, tableview)
        hStack.addArrangedSubviews(titleLabel, addPostCollectionBtn)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        hStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(viewModel.collections.count * 70)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        tableview.delegate = self
        tableview.dataSource = self
        addPostCollectionBtn.addTarget(viewModel, action: #selector(viewModel.addCollectionBtnTapped), for: .touchUpInside)
    }
}

extension PostCollectionRootView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = OptionViewTableViewCell.deque(on: tableView, at: indexPath) else { return UITableViewCell() }
        let item = viewModel.collections[indexPath.item]
        cell.titleLabel.text = item.name
        let count = item.postCount == nil ? 0 : item.postCount!
        cell.descriptionLabel.text = "Сохранено: \(count)"
        cell.radioButton.isSelected = item.isSelected
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.unSelectAllOptions()
        viewModel.activateOption(for: indexPath.item)
        tableView.reloadData()
    }
}
