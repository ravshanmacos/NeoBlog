//
//  ChooseDateViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 24/02/24.
//

import UIKit

protocol ChooseDateViewDelegate: AnyObject {
    func dateDidSelected(date: Date, periodType: PeriodType)
}

enum PeriodType {
    case start, end
}

class ChooseDateViewController: BaseViewController {
    
    //MARK: Properties
    private var rootView: ChooseDateRootView {
        return view as! ChooseDateRootView
    }
    private let periodType: PeriodType
    weak var delegate: ChooseDateViewDelegate?
    
    //MARK: Methods
    
    init(periodType: PeriodType) {
        self.periodType = periodType
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = ChooseDateRootView(periodType: periodType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.saveBtn.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
    }
    
    @objc func saveBtnTapped() {
        delegate?.dateDidSelected(date: rootView.getCurrentDate(), periodType: periodType)
        dismiss(animated: true)
    }
}
