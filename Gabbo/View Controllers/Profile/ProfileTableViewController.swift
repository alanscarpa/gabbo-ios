//
//  ProfileTableViewController.swift
//  Gabbo
//
//  Created by Alan Scarpa on 12/4/19.
//  Copyright © 2019 Gabbo. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    init() {
        super.init(style: .plain)
        tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Profile"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Profile"
        return cell
    }
    
}
