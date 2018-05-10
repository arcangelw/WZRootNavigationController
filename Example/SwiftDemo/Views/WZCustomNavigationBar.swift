//
//  WZCustomNavigationBar.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZCustomNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override var barTintColor: UIColor?{
        get { return super.barTintColor }
        set { super.barTintColor = UIColor(red:CGFloat(arc4random_uniform(255))/CGFloat(255.0), green:CGFloat(arc4random_uniform(255))/CGFloat(255.0), blue:CGFloat(arc4random_uniform(255))/CGFloat(255.0) , alpha: 1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// iOS11 无效
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100.0)
    }
    
}
