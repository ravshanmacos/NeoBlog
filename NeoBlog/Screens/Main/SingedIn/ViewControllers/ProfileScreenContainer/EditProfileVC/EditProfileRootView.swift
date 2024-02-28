//
//  EditProfileRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 28/02/24.
//

import UIKit

class EditProfileRootView: BaseView {
    //MARK: Properties
    private let changeLoginAndEmailView = makeChangeLoginAndEmailView()
    private let changePasswordView = makeChangePasswordView()
    private let vStack = makeVStack()
    
    private let viewModel: EditProfileViewModel
    
    //MARK: Methods
    
    init(frame: CGRect = .zero, viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(vStack)
        vStack.addArrangedSubviews(changeLoginAndEmailView, changePasswordView)
        
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        changeLoginAndEmailView.button.addTarget(viewModel, action: #selector(viewModel.changeEmailAndLoginTapped), for: .touchUpInside)
        changePasswordView.button.addTarget(viewModel, action: #selector(viewModel.changePasswordTapped), for: .touchUpInside)
    }
}

//MARK: Components
extension EditProfileRootView {
    static func makeChangeLoginAndEmailView() -> RowComponent {
        let component = RowComponent()
        component.configure(title: "Изменить логин или электронную почту", 
                            leftIcon: R.image.edit_icon(),
                            rightIcon: R.image.chevron_left_icon())
        return component
    }
    
    static func makeChangePasswordView() -> RowComponent {
        let component = RowComponent()
        component.configure(title: "Изменить пароль", 
                            leftIcon: R.image.lock_icon(),
                            rightIcon: R.image.chevron_left_icon())
        return component
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        return stack
    }
}
