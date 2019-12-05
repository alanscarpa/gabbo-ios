//
//  HomeTableViewCell.swift
//  Gabbo
//
//  Created by Alan Scarpa on 12/4/19.
//  Copyright © 2019 Gabbo. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let cellReuseIdentifier = "HomeTableViewCell"

    @IBOutlet weak var contentBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentBackgroundView.layer.masksToBounds = true
        contentBackgroundView.layer.cornerRadius = 10
    }

}
