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

        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .blue
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        let videoChatVC = UIViewController()
        videoChatVC.view.backgroundColor = .red
        videoChatVC.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "bubble.left.and.bubble.right"), selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill"))

        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .green
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        rootTabBarVC.setViewControllers([homeVC, videoChatVC, profileVC], animated: true)
        rootTabBarVC.selectedIndex = 1
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootTabBarVC
        window?.makeKeyAndVisible()
    }

}

