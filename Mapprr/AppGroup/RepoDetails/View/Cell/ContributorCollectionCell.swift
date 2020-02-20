//
//  ContributorCollectionCell.swift
//  Mapprr
//
//  Created by Soumya Jain on 20/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

class ContributorCollectionCell: ReusableCollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImage.setCornerRadius(radius: self.imageViewHeight.constant/2)
    }
    
    func configureCollectionCell(owner: Owner) {
        self.profileImage.kf.setImage(with: URL(string: owner.getAvatarURL() ?? ""), placeholder: Image.placeholder)
        self.ownerName.text = owner.login ?? "-"
    }
}
