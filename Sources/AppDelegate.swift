//
//  AppDelegate.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// window of App
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    /// App Tabbar
    fileprivate var tabBar = UITabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.setupTabBar()

        self.window?.rootViewController = self.tabBar
        self.window?.makeKeyAndVisible()

        return true
    }

    ///  Set up needed for Tabbar
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
