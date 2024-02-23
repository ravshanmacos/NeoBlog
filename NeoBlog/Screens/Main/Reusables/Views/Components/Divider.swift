//
//  Divider.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

class Divider: BaseView {
    
    private let straightLine: UIView = {
       let view = UIView()
        view.backgroundColor = R.color.gray_color_3()
        return view
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubviews(straightLine)
        straightLine.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
