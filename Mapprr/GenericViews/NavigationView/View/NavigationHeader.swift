//
//  NavigationHeader.swift
//  crm
//
//  Created by Soumya on 25/09/19.
//  Copyright © 2019 SmartServ. All rights reserved.
//

import UIKit

class NavigationHeader: UIView {

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var navigationTitle: UILabel!
    
    weak var delegate: NavigationHeaderProtocol?
    
    override func awakeFromNib() {
        self.configureViews()
    }
    
    func configureViews() {
        self.backgroundColor = UIColor.navigationColor
        self.leftButton.setImage(#imageLiteral(resourceName: "back.png").renderingWithAlwaysTemplateMode(), for: .normal)
        self.leftButton.tintColor = UIColor.navigationTitleColor
        self.rightButton.tintColor = UIColor.navigationTitleColor
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        self.delegate?.rightButtonAction?()
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        self.delegate?.leftButtonAction?()
    }

}
