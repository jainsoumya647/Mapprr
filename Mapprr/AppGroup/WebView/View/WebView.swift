//
//  WebView.swift
//  Mapprr
//
//  Created by Soumya Jain on 21/02/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIViewController {

    @IBOutlet weak var webViewKit: WKWebView!
    
    
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webViewKit.load(url)
        self.setNavigationView(title: "Repository", leftButtonImage: Image.back)
    }
    
    class func getController(urlString: String) -> WebView? {
        guard let vc = UIViewController.initalizeMyViewController(identifier: .webView, storyboard: .main)
            as? WebView else { return nil }
        vc.url = urlString
        return vc
    }
}

extension WebView: NavigationHeaderProtocol {
    func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
