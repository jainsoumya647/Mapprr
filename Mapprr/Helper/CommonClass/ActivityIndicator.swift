//
//  ActivityIndicator.swift
//  Blog
//
//  Created by Soumya on 15/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import DGActivityIndicatorView

class ActivityIndicator:UIView {

    struct Static {

        static var instance: ActivityIndicator?
        static var token: Int = 0
    }

    private static var __once: () = {
        Static.instance = ActivityIndicator(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }()

    class var sharedInstance: ActivityIndicator {
        _ = ActivityIndicator.__once
        return Static.instance!
    }

    var activityIndicator:DGActivityIndicatorView!

    override init(frame: CGRect) {

        super.init(frame: frame)
        self.backgroundColor = UIColor.transColor
        self.clipsToBounds = true
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showActivityIndicator(){
        DispatchQueue.main.async(execute: { () -> Void in
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
            if(self.activityIndicator != nil)
            {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
                self.activityIndicator = nil
            }

            self.activityIndicator = DGActivityIndicatorView.init(type: DGActivityIndicatorAnimationType.lineScale, tintColor: .white, size: 40.0)
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            self.activityIndicator.center = self.center
            self.activityIndicator.clipsToBounds = true
            self.activityIndicator.startAnimating()
            self.addSubview(self.activityIndicator)
            UIApplication.shared.keyWindow?.addSubview(self)
        })
    }

    func hideActivityIndicator(){
        DispatchQueue.main.async(execute: { () -> Void in
            if(self.activityIndicator != nil)
            {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
                self.activityIndicator = nil
                self.removeFromSuperview()
            }
        })
    }
}
