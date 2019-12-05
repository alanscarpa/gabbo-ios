//
//  AppDelegate.swift
//  Gabbo
//
//  Created by Alan Scarpa on 12/4/19.
//  Copyright © 2019 Gabbo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpWindow()
        return true
    }

    private func setUpWindow() {
        let rootTabBarViewController = GabboTabBarController()
        
        let homeNavigationController = GabboNavigationController(rootViewController: HomeTableViewController())
        let videoChatViewController = VideoChatViewController()
        let profileNavigationController = GabboNavigationController(rootViewController: ProfileTableViewController())
        rootTabBarViewController.setViewControllers([homeNavigationController, videoChatViewController, profileNavigationController], animated: true)
        rootTabBarViewController.selectedIndex = 1
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootTabBarViewController
        window?.makeKeyAndVisible()
    }

}

