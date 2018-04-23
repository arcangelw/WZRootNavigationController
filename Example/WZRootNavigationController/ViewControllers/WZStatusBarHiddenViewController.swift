//
//  WZStatusBarHiddenViewController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZStatusBarHiddenViewController: UIViewController {

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }

}
