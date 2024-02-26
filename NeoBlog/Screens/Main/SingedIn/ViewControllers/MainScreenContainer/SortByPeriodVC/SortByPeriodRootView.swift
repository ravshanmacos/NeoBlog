//
//  SortByPeriodRootView.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 24/02/24.
//

import UIKit
import Combine

class SortByPeriodRootView: BaseView {
    
    //MARK: Properties
    private let startPeriodPickerBtn = makePeriodChoseButton(title: "Дата начала")
    private let endPeriodPickerBtn = makePeriodChoseButton(title: "Дата конца")
    private let saveButton = makeSaveButton()
    private let vStack = makeVStack()
    private let viewModel: SortByPeriodViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: SortByPeriodViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        subscribeToStartPeriodChange()
        subscribeToEndPeriodChange()
        bindSaveButtonToViewModel()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubviews(vStack, saveButton)
        vStack.addArrangedSubviews(startPeriodPickerBtn, endPeriodPickerBtn)
        vStack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        startPeriodPickerBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        startPeriodPickerBtn.addTarget(viewModel, action: #selector(viewModel.startPeriodPickerBtnTapped), for: .touchUpInside)
        endPeriodPickerBtn.addTarget(viewModel, action: #selector(viewModel.endPeriodPickerBtnTapped), for: .touchUpInside)
        saveButton.addTarget(viewModel, action: #selector(viewModel.saveChangesButtonTapped), for: .touchUpInside)
    }
}

private extension SortByPeriodRootView {
    func subscribeToStartPeriodChange() {
        viewModel
            .$startPeriod
            .receive(on: DispatchQueue.main)
            .sink {[weak self] date in
                guard let self else { return }
                if let date {
                    startPeriodPickerBtn.setTitleColor(R.color.gray_color_1(), for: .normal)
                    startPeriodPickerBtn.setTitle(formatDate(for: date), for: .normal)
                } else {
                    startPeriodPickerBtn.setTitleColor(R.color.gray_color_2(), for: .normal)
                    startPeriodPickerBtn.setTitle("Дата начала", for: .normal)
                }
            }.store(in: &subscriptions)
    }
    
    func subscribeToEndPeriodChange() {
        viewModel
            .$endPeriod
            .receive(on: DispatchQueue.main)
            .sink {[weak self] date in
                guard let self else { return }
                if let date {
                    endPeriodPickerBtn.setTitleColor(R.color.gray_color_1(), for: .normal)
                    endPeriodPickerBtn.setTitle(formatDate(for: date), for: .normal)
                } else {
                    endPeriodPickerBtn.setTitleColor(R.color.gray_color_2(), for: .normal)
                    endPeriodPickerBtn.setTitle("Дата конца", for: .normal)
                }
            }.store(in: &subscriptions)
    }
    
    func bindSaveButtonToViewModel() {
        viewModel
            .$saveChangesButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &subscriptions)
    }
}

private extension SortByPeriodRootView {
    static func makePeriodChoseButton(title: String?) -> UIButton {
        let container = ButtonsContainer()
        let button = container.grayBckAndTitleLeftButton(title: title)
        button.layer.cornerRadius = 50/4
        return button
    }
    
    static func makeSaveButton() -> PrimaryButton {
        let button = PrimaryButton()
        button.setTitle("Применить", for: .normal)
        return button
    }
    
    static func makeVStack() -> UIStackView {
        let stackContainer = StackContainer()
        return stackContainer.filledEqualyVStack()
    }
    
    func formatDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        return dateFormatter.string(from: date)
    }
}
