//
//  EditProfileSheet.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 27/02/24.
//

import Foundation
import SwiftEntryKit
import PanModal

class EditProfileSheet: BaseViewController {
    
    //MARK: Properties
    private let twoActionSheet = TwoActionSheet()
    
    private let goToEditProfileVC: GoToEditProfileVC
    private let logoutResponder: LogoutResponder
    private let dissmissViewResponder: DissmissViewResponder
    
    //MARK: Methods
    init(goToEditProfileVC: GoToEditProfileVC, 
         logoutResponder: LogoutResponder,
         dissmissViewResponder: DissmissViewResponder) {
        self.goToEditProfileVC = goToEditProfileVC
        self.logoutResponder = logoutResponder
        self.dissmissViewResponder = dissmissViewResponder
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
        twoActionSheet.configure(title: "Еще")
        
        self.twoActionSheet.firstBtn.setTitle("Редактировать профиль", for: .normal)
        self.twoActionSheet.firstBtn.setTitleColor(R.color.gray_color_1(), for: .normal)
        self.twoActionSheet.firstBtn.setImage(R.image.edit_icon(), for: .normal)
        
        self.twoActionSheet.secondBtn.setTitle("Выйти", for: .normal)
        self.twoActionSheet.secondBtn.setTitleColor(R.color.red_color_1(), for: .normal)
        self.twoActionSheet.secondBtn.setImage(R.image.logout_icon(), for: .normal)
    }
    
    private func bindComponents() {
        twoActionSheet.firstBtn.addTarget(self, action: #selector(changeLoginAndEmailTapped), for: .touchUpInside)
        twoActionSheet.secondBtn.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc private func changeLoginAndEmailTapped() {
        goToEditProfileVC.navigateToEditProfileVC()
    }
    
    @objc private func logoutTapped() {
        dissmissViewResponder.dissmissCurrentView()
        view.showTwoActionPopUp(title: "Выйти из профиля?", firstBtnTitle: "Выйти", secondBtnTittle: "Отмена", firstBtnAction: logoutAction(), secondBtnAction: cancelAction())
    }
    
    private func logoutAction() -> UIAction {
        
        return UIAction { action in
            SwiftEntryKit.dismiss()
            self.logoutResponder.logout()
        }
    }
    
    private func cancelAction() -> UIAction {
        return UIAction { _ in
            SwiftEntryKit.dismiss()
        }
    }
}

extension EditProfileSheet: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(220)
    }
}
