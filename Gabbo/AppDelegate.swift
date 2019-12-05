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
        let rootTabBarVC = RootTabBarController()
        
        let homeVC = HomeViewController()
        let videoChatVC = VideoChatViewController()
        let profileVC = ProfileViewController()
        rootTabBarVC.setViewControllers([homeVC, videoChatVC, profileVC], animated: true)
        rootTabBarVC.selectedIndex = 1
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootTabBarVC
        window?.makeKeyAndVisible()
    }

}

