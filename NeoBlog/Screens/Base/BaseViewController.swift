//
//  BaseViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Methods
    public init() {
      super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable,
      message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable,
      message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
      fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let backButton = UIButton()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.setImage(R.image.back_icon(), for: .normal)
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func addTitle(text: String) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = R.color.gray_color_1()
        
        let titleView = UIView()
        titleView.addSubviews(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.titleView = titleView
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func addMenuBtnToRight() {
        let menuBtn = makeMenuButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
    }
    
    func addSaveBtnToRight() {
        let saveBtn = makeSaveButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveBtn)
    }
    
    func addSaveAndMenuBtnsToRight() {
        let saveBtn = makeSaveButton()
        let menuBtn = makeMenuButton()
        
        let saveRightBarItem = UIBarButtonItem(customView: saveBtn)
        let menuRightBarItem = UIBarButtonItem(customView: menuBtn)
        
        navigationItem.setRightBarButtonItems([menuRightBarItem, saveRightBarItem], animated: true)
    }
    
    private func makeMenuButton() -> UIButton {
        let menuBtn = UIButton()
        menuBtn.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        menuBtn.setImage(R.image.hambureger_menu_icon(), for: .normal)
        return menuBtn
    }
    
    private func makeSaveButton() -> UIButton {
        let saveButton = UIButton()
        saveButton.setImage(R.image.save_inactive_icon(), for: .normal)
        saveButton.setImage(R.image.save_active_icon(), for: .selected)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return saveButton
    }
    
    @objc func menuButtonTapped() {}
    @objc func saveButtonTapped(_ sender: UIButton) {}
}
