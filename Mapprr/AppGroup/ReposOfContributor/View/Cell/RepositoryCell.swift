//
//  RepositoryCell.swift
//  Mapprr
//
//  Created by Soumya Jain on 21/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

class RepositoryCell: ReusableTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(title: String) {
        self.titleLabel.text = title
    }
}
