//
//  File.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 17/02/24.
//

import UIKit

extension LabelsContainer {
    enum LabelSize {
        case large
        case large2
        case medium
        case medium2
    }
}

class LabelsContainer {
    func makeLabel(text: String, size: LabelSize) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        setSize(size: size, for: label)
        return label
    }
    
    private func setSize(size: LabelSize, for label: UILabel) {
        label.textColor = R.color.gray_color_1()
        switch size {
        case .large: label.font = .systemFont(ofSize: 32, weight: .semibold)
        case .large2: label.font = .systemFont(ofSize: 20, weight: .medium)
        case .medium: label.font = .systemFont(ofSize: 18, weight: .regular)
        case .medium2: label.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
}
