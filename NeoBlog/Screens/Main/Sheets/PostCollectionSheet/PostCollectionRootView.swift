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
            .$optionsData
            .receive(on: DispatchQueue.main)
            .sink {[weak self] optionsdata in
                guard let self else { return }
                print(optionsdata)
                tableview.reloadData()
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
            make.height.equalTo(viewModel.optionsData.count * 70)
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
        viewModel.optionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = OptionViewTableViewCell.deque(on: tableView, at: indexPath) else { return UITableViewCell() }
        let item = viewModel.optionsData[indexPath.item]
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.getSavedDescriptions()
        cell.radioButton.isSelected = item.isActive
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.unSelectAllOptions()
        viewModel.activateOption(for: indexPath.item)
        tableView.reloadData()
    }
}
