//
//  SortByPeriodViewModel.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 24/02/24.
//

import Foundation

class SortByPeriodViewModel {
    
    //MARK: Properties
    @Published var startPeriod: Date? = nil {
        didSet {
            checkPeriodsExistence()
        }
    }
    @Published var endPeriod: Date? = nil {
        didSet {
            checkPeriodsExistence()
        }
    }
    
    @Published private(set) var navigateForPeriod: PeriodType? = nil
    @Published private(set) var saveChangesButtonEnabled = false
    
    private let newPeriodCreatedResponder: NewPeriodCreatedResponder
    private let dateDidSelectedResponder: DateDidSelectedResponder
    
    //MARK: Methods
    
    init(newPeriodCreatedResponder: NewPeriodCreatedResponder, dateDidSelectedResponder: DateDidSelectedResponder) {
        self.newPeriodCreatedResponder = newPeriodCreatedResponder
        self.dateDidSelectedResponder = dateDidSelectedResponder
    }
    
    @objc func startPeriodPickerBtnTapped() {
        navigateForPeriod = .start
    }
    
    @objc func endPeriodPickerBtnTapped() {
        navigateForPeriod = .end
    }
    
    @objc func saveChangesButtonTapped() {
        dateDidSelectedResponder.datePeriodSelected(startDate: startPeriod!, endDate: endPeriod!)
    }

    private func checkPeriodsExistence() {
        guard startPeriod != nil && endPeriod != nil else { return }
        saveChangesButtonEnabled = true
    }
}
