//
//  AppDelegate.swift
//  MVVMSwift
//
//  Created by David Seca on 15.04.20.
//  Copyright © 2020 David Seca. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate var tabBar = UITabBarController()

    override init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.setupTabBar()

        self.window?.rootViewController = self.tabBar
        self.window?.makeKeyAndVisible()

        return true
    }

    private func setupTabBar() {
        let accounts = AccountsViewController()
        let accountsNavi = UINavigationController(rootViewController: accounts)

        let about = AboutViewController()
        let aboutNavi = UINavigationController(rootViewController: about)

        self.tabBar.viewControllers = [ accountsNavi, aboutNavi ]

        // disable editing of tab bar items
        self.tabBar.customizableViewControllers = nil

        self.tabBar.selectedIndex = 0
    }

}
