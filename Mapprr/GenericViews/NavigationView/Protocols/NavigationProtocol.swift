//
//  NavigationProtocol.swift
//  crm
//
//  Created by Soumya on 26/09/19.
//  Copyright © 2019 SmartServ. All rights reserved.
//

import Foundation


@objc protocol NavigationHeaderProtocol: class {
    @objc optional func rightButtonAction()
    @objc optional func leftButtonAction()
}
