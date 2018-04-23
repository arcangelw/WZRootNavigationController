//
//  WZNavigationBarHiddenViewController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZNavigationBarHiddenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wz_prefersNavigationBarHidden = true
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
