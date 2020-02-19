//
//  RepoDetailsCell.swift
//  Mapprr
//
//  Created by Soumya Jain on 20/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

class RepoDetailsCell: ReusableTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.descriptionLabel.isHidden = description.isEmpty
    }
}
