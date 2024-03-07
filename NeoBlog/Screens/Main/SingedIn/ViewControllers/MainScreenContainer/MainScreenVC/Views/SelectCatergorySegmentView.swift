//
//  SelectCatergorySegmentView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 21/02/24.
//

import UIKit
import Combine

class SelectCatergorySegmentView: BaseView {
    //MARK: Properties
    private let collectionVew: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: CategoryViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindings()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(collectionVew)
        collectionVew.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        collectionVew.dataSource = self
        collectionVew.delegate = self
        TitlesCategoryCollectionViewCell.register(to: collectionVew)
    }
}

extension SelectCatergorySegmentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = TitlesCategoryCollectionViewCell.deque(on: collectionView, at: indexPath) else {
            return UICollectionViewCell()
        }
        let item = viewModel.categories[indexPath.item]
        cell.setTitle(text: item.name)
        item.active ? cell.activateCell() : cell.disableCell()
        return cell
    }
}

extension SelectCatergorySegmentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.activateCategorFor(index: indexPath.item)
    }
}

extension SelectCatergorySegmentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = viewModel.categories[indexPath.item].name
        label.sizeToFit()
        return .init(width: label.frame.width + 20, height: label.frame.height + 10)
    }
}


private extension SelectCatergorySegmentView {
    func bindings() {
        if let mainScreenViewModel = viewModel as? MainScreenViewModel {
            mainScreenViewModel
                .$categories
                .receive(on: DispatchQueue.main)
                .sink {[weak self] _ in
                    guard let self else { return }
                    collectionVew.reloadData()
                }.store(in: &subscriptions)
        }
            
    }
}
