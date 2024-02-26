//
//  StackContainer.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

class StackContainer {
    func filledVStack() -> UIStackView {
        let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = 15
         stack.distribution = .fill
         return stack
    }
    
    func filledEqualyVStack() -> UIStackView {
        let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = 15
         stack.distribution = .fillEqually
         return stack
    }
    
    func filledEqualyHStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }
    
    func filledVStack(spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = spacing
         stack.distribution = .fill
         return stack
    }
}
