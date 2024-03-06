//
//  SelectCatergorySegmentView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 21/02/24.
//

import UIKit

class CategoryItem {
    let title: String
    var active: Bool
    
    init(title: String, active: Bool = false) {
        self.title = title
        self.active = active
    }
}

protocol SelectCatergorySegmentViewDelegate: AnyObject {
    func categoryDidSelected(item: CategoryItem)
}

class SelectCatergorySegmentView: BaseView {
    //MARK: Properties
    private let categoryCollectionVew = makeCategoryCollection()
    private var categoryList: [CategoryItem]
    
    weak var delegate: SelectCatergorySegmentViewDelegate?
    
    //MARK: Methods
    init(frame: CGRect = .zero, categoryList: [CategoryItem]) {
        self.categoryList = categoryList
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(categoryCollectionVew)
        categoryCollectionVew.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        categoryCollectionVew.dataSource = self
        categoryCollectionVew.delegate = self
        TitlesCategoryCollectionViewCell.register(to: categoryCollectionVew)
    }
}

extension SelectCatergorySegmentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = TitlesCategoryCollectionViewCell.deque(on: collectionView, at: indexPath) else {
            return UICollectionViewCell()
        }
        let item = categoryList[indexPath.item]
        cell.setTitle(text: item.title)
        item.active ? cell.activateCell() : cell.disableCell()
        return cell
    }
}

extension SelectCatergorySegmentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoryList.forEach { $0.active = false }
        categoryList[indexPath.row].active = true
        collectionView.reloadData()
        delegate?.categoryDidSelected(item: categoryList[indexPath.item])
    }
}

extension SelectCatergorySegmentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = categoryList[indexPath.item].title
        label.sizeToFit()
        return .init(width: label.frame.width + 20, height: label.frame.height + 10)
    }
}


private extension SelectCatergorySegmentView {
    static func makeCategoryCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
}
