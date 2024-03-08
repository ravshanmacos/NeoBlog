//
//  PrimaryTwoActionSheet.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 08/03/24.
//

import Foundation
import SwiftEntryKit
import PanModal

protocol PrimaryTwoActionSheetViewModel {
    func primaryTwoActionSheetFirstBtnTapped()
    func primaryTwoActionSheetSecondBtnTapped()
}

class PrimaryTwoActionSheet: BaseViewController {
    
    //MARK: Properties
    private let twoActionSheet = TwoActionSheetPrimary()
    
    //MARK: Methods
    private let viewModel: PrimaryTwoActionSheetViewModel
    private let sheetTitle: String
    private let sheetSubtitle: String
    private let sheetFirstActionBtnTitle: String
    private let sheetSecondActionBtnTitle: String
    
    init(viewModel: PrimaryTwoActionSheetViewModel, title: String, subtitle: String = "",
         firstActionBtnTitle: String, secondActionBtnTitle: String) {
        self.viewModel = viewModel
        self.sheetTitle = title
        self.sheetSubtitle = subtitle
        self.sheetFirstActionBtnTitle = firstActionBtnTitle
        self.sheetSecondActionBtnTitle = secondActionBtnTitle
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = twoActionSheet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindComponents()
    }
    
    private func configureView() {
        twoActionSheet.titleLabel.text = sheetTitle
        twoActionSheet.descriptionLabel.text = sheetSubtitle
        twoActionSheet.firstActionBtn.setTitle(sheetFirstActionBtnTitle, for: .normal)
        twoActionSheet.secondActionBtn.setTitle(sheetSecondActionBtnTitle, for: .normal)
    }
    
    private func bindComponents() {
        twoActionSheet.firstActionBtn.addTarget(self, action: #selector(changeLoginAndEmailTapped), for: .touchUpInside)
        twoActionSheet.secondActionBtn.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc private func changeLoginAndEmailTapped() {
        viewModel.primaryTwoActionSheetFirstBtnTapped()
    }
    
    @objc private func logoutTapped() {
        viewModel.primaryTwoActionSheetSecondBtnTapped()
    }
}

extension PrimaryTwoActionSheet: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(220)
    }
}
