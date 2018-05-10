//
//  WZCustomAnimationDetailViewController.swift
//  SwiftDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WZRootNavigationController

class WZCustomAnimationDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        wz_animationProcessing = WZRootTransitionAnimationProcess(type:.custom(animation: WZCustomAnimation()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        wz_animationProcessing = WZRootTransitionAnimationProcess(type:.custom(animation: WZCustomAnimation()))
    }
}
