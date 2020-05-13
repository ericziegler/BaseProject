//
// BaseTabBarController.swift
//

import UIKit

class BaseTabBarController: UITabBarController {

    var curTabIndex = 0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tabItems = tabBar.items {
            for i in 0..<tabItems.count {
                if item == tabItems[i] {
                    if curTabIndex == i {
                        // user tapped tab they were already on. pop to root view controller
                        if let controllers = viewControllers, let navController = controllers[i] as? BaseNavigationController {
                            navController.popToRootViewController(animated: true)
                        }
                    }
                    curTabIndex = i
                    break
                }
            }
        }
    }

}
