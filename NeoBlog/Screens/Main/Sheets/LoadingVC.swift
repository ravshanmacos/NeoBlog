//
//  LoadingVC.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 07/03/24.
//

import UIKit

class LoadingVC: BaseViewController {
    //MARK: Properties
    private let loadingIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingIndicatorView.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loadingIndicatorView.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        configureUI()
    }
    
    private func setupSubviews() {
        view.addSubviews(loadingIndicatorView)
        loadingIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
    }
}

