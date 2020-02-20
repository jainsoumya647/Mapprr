//
//  UIViewController+Extension.swift
//  Blog
//
//  Created by Soumya on 14/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @discardableResult func setNavigationView(title: String, leftButtonImage: UIImage? = nil, leftTitle: String? = nil, rightButtonImage: UIImage? = nil, rightTitle: String? = nil) -> NavigationHeader? {
        if let navigation = UIViewController.getInstanceFromNib(withName: .navigationHeader) as? NavigationHeader {
            navigation.navigationTitle.text = title
            
            navigation.leftButton.isHidden = (leftButtonImage == nil && leftTitle == nil)
            navigation.leftButton.setImage(leftButtonImage?.renderingWithAlwaysTemplateMode(), for: .normal)
            
            navigation.leftButton.tintColor = .navigationTitleColor
            navigation.leftButton.setTitle(leftTitle, for: .normal)
            navigation.leftButton.setTitleColor(.navigationTitleColor, for: .normal)

            navigation.rightButton.isHidden = (rightButtonImage == nil && rightTitle == nil)
            navigation.rightButton.setImage(rightButtonImage?.renderingWithAlwaysTemplateMode(), for: .normal)

            navigation.rightButton.tintColor = .navigationTitleColor
            navigation.rightButton.setTitle(rightTitle, for: .normal)
            navigation.rightButton.setTitleColor(.navigationTitleColor, for: .normal)

            navigation.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Height.naviagtionHeight)
            navigation.delegate = self as? NavigationHeaderProtocol
            self.view.addSubview(navigation)
            return navigation
        }
        return nil
    }
    
    class func getInstanceFromNib(withName name: NibName) -> UIView? {
        return UINib(nibName: name.rawValue, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func presentOkAlertWith(title: String?, message: String?) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func register(table: UITableView, seperatorStyle: UITableViewCell.SeparatorStyle = .none) {
        table.dataSource = self as? UITableViewDataSource
        table.delegate = self as? UITableViewDelegate
        table.separatorStyle = seperatorStyle
        table.tableFooterView = UIView()
        table.alwaysBounceVertical = false
    }

    func register(_ collectionView: UICollectionView) {
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.delegate = self as? UICollectionViewDelegateFlowLayout
    }

    class func initalizeMyViewController(identifier: Controller, storyboard: Storyboard) -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: identifier.rawValue)
    }
}
