//
//  UIApplication+Extension.swift
//  Blog
//
//  Created by Soumya on 14/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

extension UIApplication {

    var topSafeArea: CGFloat {
        if #available(iOS 11.0, *) {
            return self.keyWindow?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
