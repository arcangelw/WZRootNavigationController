//
//  UIKitExtension.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/20.
//  Copyright © 2018年 arcangelw All rights reserved.
//

import UIKit

extension CGPoint{
    
    public func wz_direction() -> UIRectEdge{
        if abs(self.x) >= abs(self.y){
            return self.x > 0.0 ? .left : .right
        }else{
            return self.y > 0.0 ? .top : .bottom
        }
    }
}

extension UIPanGestureRecognizer {
    
    @objc public var wz_direction:UIRectEdge{
        return self.translation(in: self.view).wz_direction()
    }
    
    @objc public func wz_direction(in view:UIView?) -> UIRectEdge{
        return self.translation(in: view).wz_direction()
    }
}

extension UIView {
    
    @objc public var wz_scrollView:UIScrollView? {
        if let scrollView = self as? UIScrollView {
            return scrollView
        }
        return superview?.wz_scrollView ?? nil
    }
    
    /// 是否在 view 范围内
    @objc public func wz_isContains(inView view:UIView) -> Bool{
        if isHidden {
           return false
        }
        guard let _ = superview else {
            return false
        }
        let rect = convert(bounds, to: view)
        return view.bounds.contains(rect)
    }
}

extension UIScrollView {
    /// 滑动到最顶部
    @objc public var wz_isSlidingToEdgeTop:Bool {
        if isScrollEnabled == false { return true }
        if contentOffset.y <= 0.0 {
            return superview?.wz_scrollView?.wz_isSlidingToEdgeTop ?? true
        }
        return false
    }
    /// 滑动到最左侧
    @objc public var wz_isSlidingToEdgeLeft:Bool {
        if isScrollEnabled == false { return true }
        if contentOffset.x <= 0.0 {
            return superview?.wz_scrollView?.wz_isSlidingToEdgeLeft ?? true
        }
        return false
    }
    /// 滑动到最底部
    @objc public var wz_isSlidingToEdgeBottom:Bool {
        if isScrollEnabled == false { return true }
        if contentOffset.y >= contentSize.height - frame.height {
            return superview?.wz_scrollView?.wz_isSlidingToEdgeBottom ?? true
        }
        return false
    }
    /// 滑动到最右侧
    @objc public var wz_isSlidingToEdgeRight:Bool {
        if isScrollEnabled == false { return true }
        if contentOffset.x >= contentSize.width - frame.width {
            return superview?.wz_scrollView?.wz_isSlidingToEdgeRight ?? true
        }
        return false
    }
}
