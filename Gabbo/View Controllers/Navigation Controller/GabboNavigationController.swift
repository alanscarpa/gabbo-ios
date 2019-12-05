//
//  GabboNavigationController.swift
//  Gabbo
//
//  Created by Alan Scarpa on 12/5/19.
//  Copyright © 2019 Gabbo. All rights reserved.
//

import UIKit

class GabboNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        configureNavigationBarColor()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.hasDifferentColorAppearance(comparedTo: UITraitCollection.current) == true {
            configureNavigationBarColor()
        }
    }

    private func configureNavigationBarColor() {
        navigationBar.barTintColor = UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white
        
        // This is odd behavior.
        // If we set the navBar largeTitle barTintColor to black,
        // then isTranslucent needs to be false.
        // If we set it to white,
        // then isTranslucent needs to be true.
        // Otherwise, the colors shown are opposite!
        navigationBar.isTranslucent = !(UITraitCollection.current.userInterfaceStyle == .dark)
    }

}
