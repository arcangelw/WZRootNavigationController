//
//  WZUIViewControllerExtensions.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit
import Foundation

private struct WZAssociatedKeys{
    static var prefersNavigationBarHiddenKey: UInt8 = 0
    static var interactivePopDisabled: UInt8 = 0
    static var interactivePopAllowedEdge: UInt8 = 0
}

extension CGPoint{
    
    public func wz_direction() -> WZGestureDirection{
        if abs(self.x) >= abs(self.y){
            return self.x < 0.0 ? .left : .right
        }else{
            return self.y < 0.0 ? .top : .bottom
        }
    }
}

extension UIView {
    
    public var wz_scrollView:UIScrollView? {
        if let scrollView = self as? UIScrollView {
            return scrollView
        }
        if let supeView = self.superview {
            return superview?.wz_scrollView
        }
        return nil
    }
}

extension UIScrollView {
    /// 已经滑动到了边缘
    @objc public var wz_isSlidingToEdge:Bool {
        if self.isScrollEnabled == false { return true }
        if self.contentOffset.x <= 0.0 || self.contentOffset.x >= self.contentSize.width || self.contentOffset.y <= 0.0 || self.contentOffset.y >= self.contentSize.height {
            return self.superview?.wz_scrollView?.wz_isSlidingToEdge ?? true
        }
        return false
    }
}

@IBDesignable
extension UIViewController {
    
    /// 自定义导航栏
    @objc open var wz_navigationBarClass: UINavigationBar.Type? {
        return nil
    }
    
    /// 转场动画配置
    @objc open var wz_animatedTransitionPluginClass:WZAnimatedTransitionPlugin.Type {
        return WZAnimatedTransitionPlugin.self
    }
    
    /// 自定义滑动手势处理
    @objc open var wz_gesturePluginClass:WZGesturePlugin.Type {
        return WZGesturePlugin.self
    }
    
    /// 获取navigationController WZRootNavigationController
    public var wz_navigationController:WZRootNavigationController? {
        var vc:UIViewController? = self
        while vc != nil && ( vc is WZRootNavigationController ) == false {
            vc = vc?.navigationController
        }
        return vc as? WZRootNavigationController
    }
    
    /// UIViewController view 允许交互的边缘设置 默认 .zero 允许全屏交互
    @IBInspectable public var wz_interactivePopAllowedEdge:UIEdgeInsets {
        get{
            guard let value = objc_getAssociatedObject(self, &WZAssociatedKeys.interactivePopAllowedEdge) as? UIEdgeInsets else {
                return .zero
            }
            return value
        }
        set{
            objc_setAssociatedObject(self, &WZAssociatedKeys.interactivePopAllowedEdge, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    /// 是否关闭手势pop交互 默认 false
    @IBInspectable public var wz_interactivePopDisabled:Bool {
        get{
            guard let value = objc_getAssociatedObject(self, &WZAssociatedKeys.interactivePopDisabled) as? Bool else {
                return false
            }
            return value
        }
        set{
            objc_setAssociatedObject(self, &WZAssociatedKeys.interactivePopDisabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 是否隐藏导航栏 默认 false
    @IBInspectable public var wz_prefersNavigationBarHidden:Bool {
        get{
            guard let value = objc_getAssociatedObject(self, &WZAssociatedKeys.prefersNavigationBarHiddenKey) as? Bool else {
                return false
            }
            return value
        }
        set{
            objc_setAssociatedObject(self, &WZAssociatedKeys.prefersNavigationBarHiddenKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 自定义 leftBarButtonItem
    @objc open func wz_customBackItem(withTarget target: Any?, action aSelector: Selector) -> UIBarButtonItem? { return nil }
}
