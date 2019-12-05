//
//  GabboTableViewController.swift
//  Gabbo
//
//  Created by Alan Scarpa on 12/5/19.
//  Copyright © 2019 Gabbo. All rights reserved.
//

import UIKit

class GabboTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.hasDifferentColorAppearance(comparedTo: UITraitCollection.current) == true {
            configureBackgroundColor()
        }
    }

    private func configureBackgroundColor() {
        view.backgroundColor = UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white
    }
}
