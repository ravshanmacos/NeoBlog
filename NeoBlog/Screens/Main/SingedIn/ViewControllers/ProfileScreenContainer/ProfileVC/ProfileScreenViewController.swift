//
//  ProfileScreenViewController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

protocol ProfileViewModelFactory {
    func makeProfileViewModel() -> ProfileScreenViewModel
}

class ProfileScreenViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: ProfileViewModelFactory
    private let viewModel: ProfileScreenViewModel
    private let userProfile: UserProfile
    
    private var rootView: ProfileScreenRootView {
        return view as! ProfileScreenRootView
    }
    
    //MARK: Methods
    
    init(userProfile: UserProfile, viewModelFactory: ProfileViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.userProfile = userProfile
        self.viewModel = viewModelFactory.makeProfileViewModel()
        self.viewModel.userID = userProfile.id
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = ProfileScreenRootView(viewModel: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsername()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMyPosts()
        viewModel.getCollections()
    }
    
    func getUsername() {
        rootView.setUserName(text: userProfile.username ?? "UserName")
    }
}
