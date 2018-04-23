//
//  WZCustomNavigationBar.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZCustomNavigationBar: UINavigationBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return super.sizeThatFits(CGSize(width: size.width, height:80.0))
    }
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        path.lineWidth = 2.0
        UIColor.black.setStroke()
        UIColor.green.setFill()
        path.fill()
        path.stroke()
    }
}
