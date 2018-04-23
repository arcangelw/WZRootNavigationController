//
//  WZUIWebViewController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZUIWebViewController: UIViewController {

    let uiWebView:UIWebView = UIWebView()
    let activity:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .green
        activity.tintColor = .green
        return activity
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(uiWebView)
        uiWebView.frame = view.bounds
        uiWebView.delegate = self
        uiWebView.loadRequest(URLRequest(url: URL(string: "https://github.com/arcangelw/WZRootNavigationController")!))
        view.addSubview(activity)
        activity.center = uiWebView.center
        
    }
    
}

extension WZUIWebViewController:UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activity.stopAnimating()
    }
}

