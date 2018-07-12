//
//  WZCustomAnimatedListHeadView.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/6/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

@objc public final class WZCustomAnimatedListHeadView: UICollectionReusableView {
    
    @objc public let imageView = UIImageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView(240)]", options: [], metrics: nil, views: ["imageView":imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: ["imageView":imageView]))
    }
}
