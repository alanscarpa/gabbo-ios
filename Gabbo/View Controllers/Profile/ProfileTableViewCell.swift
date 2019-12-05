//
//  ProfileTableViewCell.swift
//  Gabbo
//
//  Created by Alan Scarpa on 12/4/19.
//  Copyright © 2019 Gabbo. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    static let cellReuseIdentifier = "ProfileTableViewCell"

    @IBOutlet weak var contentBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentBackgroundView.layer.masksToBounds = true
        contentBackgroundView.layer.cornerRadius = 10
    }
    
}
