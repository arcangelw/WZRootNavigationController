//
//  UIViewControllerExtension.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/5/10.
//  Copyright © 2018年 arcangelw All rights reserved.
//

import UIKit

fileprivate var WZConfigKey:UInt8 = 0

@IBDesignable
extension UIViewController:WZRootNavigationItemCustomProtocol {
    
    @IBInspectable @objc public var wz_rootContentConfig:WZRootContentConfigProtocol {
        get {
            guard let value = objc_getAssociatedObject(self, &WZConfigKey) as? WZRootContentConfigProtocol else {
                self.wz_rootContentConfig = WZRootContentConfig()
                return self.wz_rootContentConfig
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &WZConfigKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 获取navigationController WZRootNavigationController
    @objc public var wz_navigationController:WZRootNavigationController? {
        var vc:UIViewController? = self
        while vc != nil && ( vc is WZRootNavigationController ) == false {
            vc = vc?.navigationController
        }
        return vc as? WZRootNavigationController
    }
    
    @IBInspectable open var wz_navigationBarClass: UINavigationBar.Type? {
        get {
            return wz_rootContentConfig.navigationBarClass
        }
        set {
            wz_rootContentConfig.navigationBarClass = newValue
        }
    }
    
    @IBInspectable public var wz_popEdge: UIRectEdge {
        get {
            return wz_rootContentConfig.popEdge
        }
        set {
            wz_rootContentConfig.popEdge = newValue
        }
    }
    
    @IBInspectable public var wz_popAllowedEdge: UIEdgeInsets {
        get {
            return wz_rootContentConfig.popAllowedEdge
        }
        set {
            wz_rootContentConfig.popAllowedEdge = newValue
        }
    }
    
    @IBInspectable public var wz_popGestureProcessing: WZGestureRecognizerDelegate {
        get {
            return wz_rootContentConfig.popGestureProcessing
        }
        set {
            wz_rootContentConfig.popGestureProcessing = newValue
        }
    }
    
    @IBInspectable public var wz_animationProcessing: WZTransitionAnimationConvert {
        get {
            return wz_rootContentConfig.animationProcessing
        }
        set {
            wz_rootContentConfig.animationProcessing = newValue
        }
    }
    
    @IBInspectable public var wz_prefersNavigationBarHidden: Bool {
        get {
            return wz_rootContentConfig.prefersNavigationBarHidden
        }
        set {
            wz_rootContentConfig.prefersNavigationBarHidden = newValue
        }
    }
    
}
