//
//  WZTabBarController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/7/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZTabBarController: UITabBarController {
    
    override var prefersStatusBarHidden: Bool{
        return (selectedViewController != nil) ? selectedViewController!.prefersStatusBarHidden : super.prefersStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation
    {
        return (selectedViewController != nil) ? selectedViewController!.preferredStatusBarUpdateAnimation : super.preferredStatusBarUpdateAnimation
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return (selectedViewController != nil) ? selectedViewController!.preferredStatusBarStyle : super.preferredStatusBarStyle
    }
    
}
