//
//  WelcomeRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit
import SnapKit

class WelcomeRootView: BaseView {
    //MARK: Properties
    private let welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "NeoBlog"
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textColor = R.color.blue_color_1()
        return label
    }()
    
    private let welcomeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = R.image.welcomeScreenImage()
        return imageView
    }()
    
    private let signInButton: PrimaryButton = {
       let button = PrimaryButton()
        button.setTitle("Войти", for: .normal)
        return button
    }()
    
    private let signUpButton: SecondaryButton = {
       let button = SecondaryButton()
        button.setTitle("Регистрация", for: .normal)
        return button
    }()
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let viewModel: WelcomeViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(welcomeTitleLabel, welcomeImageView, vStack)
        vStack.addArrangedSubviews(signInButton, signUpButton)
        
        welcomeTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(snp.centerY).multipliedBy(0.6)
        }
        
        welcomeImageView.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        vStack.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .white
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
}

@objc extension WelcomeRootView {
    func signInTapped() {
        viewModel.signIn()
    }
    
    func signUpTapped() {
        viewModel.signUp()
    }
}
