//
//  BaseView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

class BaseView: UIView {
    
    //MARK: Properties
    let contentView: UIView = {
       let view = UIView()
        
        return view
    }()
    
    // MARK: - Methods
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        configureAppearance()
        
    }

    @available(*, unavailable,
      message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    )
    required init?(coder aDecoder: NSCoder) {
      fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func setupSubviews(){
        addSubviews(contentView)
    }
    func setupConstraints(){
        let safeArea = safeAreaLayoutGuide
        contentView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(10)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-10)
            make.leading.equalTo(safeArea.snp.leading).offset(15)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-15)
        }
    }
    func configureAppearance(){
        backgroundColor = .white
    }
}
