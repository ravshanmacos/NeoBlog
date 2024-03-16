//
//  EmptyPostsView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 07/03/24.
//

import UIKit

protocol EmptyPostViewModel {
    func createPostTapped()
}

class EmptyPostsView: BaseView {
    //MARK: Properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "У вас еще нет постов"
        label.textAlignment = .center
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Здесь будут показаны посты, созданные вами"
        
        label.numberOfLines = 2
        label.setLineSpacing(lineHeightMultiple: 1.2)
        label.textAlignment = .center
        label.textColor = R.color.gray_color_2()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let createPostBtn: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = R.color.blue_color_2()?.cgColor
        return button
    }()
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        return stack
    }()
    
    private let viewModel: EmptyPostViewModel
    
    //MARK: Methods
    
    init(frame: CGRect = .zero, viewModel: EmptyPostViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(vStack)
        vStack.addArrangedSubviews(titleLabel, descriptionLabel, createPostBtn)
        
        vStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        createPostBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        createPostBtn.setTitle("Создать пост", for: .normal)
        createPostBtn.setTitleColor(R.color.blue_color_1(), for: .normal)
        createPostBtn.setImage(R.image.circular_plus_icon(), for: .normal)
        createPostBtn.imageEdgeInsets.right = 10
        
        createPostBtn.addTarget(self, action: #selector(createPostBtnTapped), for: .touchUpInside)
    }
    
    @objc private func createPostBtnTapped() {
        viewModel.createPostTapped()
    }
}
