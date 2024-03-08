//
//  SecondaryTwoActionSheet.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 08/03/24.
//

import Foundation
import SwiftEntryKit
import PanModal

protocol SecondaryTwoActionSheetViewModel {
    func secondaryTwoActionSheetFirstBtnTapped()
    func secondaryTwoActionSheetSecondBtnTapped()
}

class SecondaryTwoActionSheet: BaseViewController {
    
    //MARK: Properties
    private let twoActionSheet = TwoActionSheetSecondary()
    
    //MARK: Methods
    private let viewModel: SecondaryTwoActionSheetViewModel
    private let sheetTitle: String
    private let sheetSubtitle: String
    private let sheetFirstActionBtnTitle: String
    private let sheetSecondActionBtnTitle: String
    private let sheetFirstActionBtnImage: UIImage
    private let sheetSecondActionBtnImage: UIImage
    
    init(viewModel: SecondaryTwoActionSheetViewModel, title: String, subtitle: String = "",
         firstActionBtnTitle: String, secondActionBtnTitle: String, sheetFirstActionBtnImage: UIImage, sheetSecondActionBtnImage: UIImage) {
        self.viewModel = viewModel
        self.sheetTitle = title
        self.sheetSubtitle = subtitle
        self.sheetFirstActionBtnTitle = firstActionBtnTitle
        self.sheetSecondActionBtnTitle = secondActionBtnTitle
        self.sheetFirstActionBtnImage = sheetFirstActionBtnImage
        self.sheetSecondActionBtnImage = sheetSecondActionBtnImage
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
        
        twoActionSheet.firstActionBtn.setImage(sheetFirstActionBtnImage, for: .normal)
        twoActionSheet.secondActionBtn.setImage(sheetSecondActionBtnImage, for: .normal)
    }
    
    private func bindComponents() {
        twoActionSheet.firstActionBtn.addTarget(self, action: #selector(changeLoginAndEmailTapped), for: .touchUpInside)
        twoActionSheet.secondActionBtn.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc private func changeLoginAndEmailTapped() {
        viewModel.secondaryTwoActionSheetFirstBtnTapped()
    }
    
    @objc private func logoutTapped() {
        viewModel.secondaryTwoActionSheetSecondBtnTapped()
    }
}

extension SecondaryTwoActionSheet: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(220)
    }
}
