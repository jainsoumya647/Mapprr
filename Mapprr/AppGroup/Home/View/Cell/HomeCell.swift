//
//  HomeCell.swift
//  Mapprr
//
//  Created by Soumya Jain on 19/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

class HomeCell: ReusableTableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var watchersCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }

    func setupCell() {
        self.outerView.setCornerRadiusAndShadow()
    }
    
    func configureCell(repo: Repository) {
        self.nameLabel.text = "Name: \(repo.getName())"
        self.fullNameLabel.text = "Full Name: \(repo.getFullName())"
        self.watchersCount.text = "Watcher's Count: \(repo.getWatchersCount())"
    }
}
