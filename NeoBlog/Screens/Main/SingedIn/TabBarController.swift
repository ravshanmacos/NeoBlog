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
    //case thirdTab
}

class TabBarController: UITabBarController {
    
    //MARK: Properties
    private let mainContainerViewController: MainContainerViewController
    private let addPostContainerViewController: AddPostContainerViewController
    private let profileScreenViewController: ProfileScreenViewController
    
    //MARK: Methods
    init(mainContainerViewController: MainContainerViewController,
         addPostContainerViewController: AddPostContainerViewController,
         profileScreenViewController: ProfileScreenViewController) {
        self.mainContainerViewController = mainContainerViewController
        self.addPostContainerViewController = addPostContainerViewController
        self.profileScreenViewController = profileScreenViewController
        super.init(nibName: nil, bundle: nil)
        configureController()
        setTabbarAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureController() {
        let controllers: [BaseNavigationController] = Tabs.allCases.map { tab in
            let controller = getController(for: tab)
            controller.tabBarItem.image = Constants.Images.TabBar.image(for: tab)
            controller.tabBarItem.title = Constants.Strings.TabBar.title(for: tab)
            controller.tabBarItem.tag = tab.rawValue
            return controller
        }
        setViewControllers(controllers, animated: true)
    }
    
    private func getController(for tab: Tabs) -> BaseNavigationController {
        switch tab {
        case .firstTab: return mainContainerViewController
        case .secondTab: return addPostContainerViewController
        //case .thirdTab: return profileScreenViewController
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
    
    func switchToTab(tab: Tabs) {
        selectedIndex = tab.rawValue
    }
}
