//
//  WZWebViewController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/5/14.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WZRootNavigationController
import WebKit

class WZWebViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        wz_popGestureProcessing = WZRootTransitionScreenEdgeGestureProcess()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        wz_popGestureProcessing = WZRootTransitionScreenEdgeGestureProcess()
    }
    
    private lazy var webView:WKWebView = {
        let web = WKWebView(frame: self.view.bounds)
        web.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        web.allowsBackForwardNavigationGestures = true
        web.navigationDelegate = self
        return web
    }()
    
    private let indicatorView:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        if let g =  webView.gestureRecognizers?.first(where: ({$0 is UIScreenEdgePanGestureRecognizer})){
            wz_popGestureProcessing.popGestureRecognizer.require(toFail: g)
        }
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.isTranslucent = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicatorView)
        
        let backItem = UIBarButtonItem(title: "<", style: .plain, target: webView, action: #selector(webView.goBack))
        backItem.isEnabled = false
        
        let forward = UIBarButtonItem(title: ">", style: .plain, target: webView, action: #selector(webView.goForward))
        forward.isEnabled = false
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.share))
        toolbarItems = [backItem,
                       UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                        forward,
                        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                        share]
        webView.load(URLRequest(url: URL(string: "https://github.com")!))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @objc func share(){
        let activity = UIActivityViewController(activityItems: [webView.url!], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
}

extension WZWebViewController:WKNavigationDelegate {
    
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.stopAnimating()
        navigationItem.title = webView.title
        toolbarItems?[0].isEnabled = webView.canGoBack
        toolbarItems?[2].isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicatorView.stopAnimating()
    }
}
