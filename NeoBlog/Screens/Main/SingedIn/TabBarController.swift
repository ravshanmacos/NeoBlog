//
//  TabBarController.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 19/02/24.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case firstTab
    case secondTab
    case thirdTab
}

class TabBarController: UITabBarController {
    
    //MARK: Properties
    private let mainScreenViewController: MainScreenViewController
    private let addPostScreenViewController: AddPostScreenViewController
    private let profileScreenViewController: ProfileScreenViewController
    
    //MARK: Methods
    init(mainScreenViewController: MainScreenViewController, 
         addPostScreenViewController: AddPostScreenViewController,
         profileScreenViewController: ProfileScreenViewController) {
        self.mainScreenViewController = mainScreenViewController
        self.addPostScreenViewController = addPostScreenViewController
        self.profileScreenViewController = profileScreenViewController
        super.init(nibName: nil, bundle: nil)
        configureController()
        setTabbarAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureController() {
        let controllers: [UINavigationController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(rootViewController: getController(for: tab))
            controller.tabBarItem.image = Constants.Images.TabBar.image(for: tab)
            controller.tabBarItem.title = Constants.Strings.TabBar.title(for: tab)
            controller.tabBarItem.tag = tab.rawValue
            return controller
        }
        setViewControllers(controllers, animated: true)
    }
    
    private func getController(for tab: Tabs) -> BaseViewController {
        switch tab {
        case .firstTab: return mainScreenViewController
        case .secondTab: return addPostScreenViewController
        case .thirdTab: return profileScreenViewController
        }
    }
    
    private func setTabbarAppearance() {
        if let items = tabBar.items {
            for item in items {
                if item.tag == 1 {
                    item.imageInsets = .init(top: -25, left: 0, bottom: 0, right: 0)
                }
            }
        }
    }
}
