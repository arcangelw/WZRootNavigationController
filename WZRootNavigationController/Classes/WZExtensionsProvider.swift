//
//  WZExtensionsProvider.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit

public protocol WZExtensionsProvider where Self : UIViewController{
    
    ///* 自定义导航栏
    var wz_navigationBarClass:UINavigationBar.Type? { get }
    
    ///* 转场动画配置
    var wz_animatedTransitionClass:WZViewControllerAnimatedTransition.Type { get }
    
    ///* 自定义滑动手势处理
    var wz_gestureRecognizerDelegateClass:WZViewGestureRecognizerDelegate.Type { get }

    ///* push支持动画类型 默认 .push
    ///* 配合 wz_animatedTransitionClass  wz_gestureRecognizerDelegateClass 可以 自定义push动画
    var wz_pushAnimatedType:WZViewControllerPushAnimatedType { get }
    
    ///* pop支持动画类型 默认 WZViewControllerDefaultPopAnimatedOptionsInfo
    ///* 配合 wz_animatedTransitionClass  wz_gestureRecognizerDelegateClass 可以 自定义pop动画
    var wz_popAnimatedOptionsInfo:WZViewControllerPopAnimatedOptionsInfo { get }
    
    ///* 获取navigationController WZRootNavigationController
    var wz_navigationController:WZRootNavigationController? { get }
    
    ///* 是否关闭手势pop交互 默认 false
    var wz_interactivePopDisabled:Bool { get set }
    
    ///* 是否隐藏导航栏 默认 false
    var wz_prefersNavigationBarHidden:Bool { get set }
    
}

private struct WZAssociatedKeys{
    static var prefersNavigationBarHiddenKey: UInt8 = 0
    static var interactivePopDisabled: UInt8 = 0
}

extension WZExtensionsProvider {
    
    public var wz_navigationBarClass: UINavigationBar.Type? {
        return nil
    }
    
    public var wz_animatedTransitionClass:WZViewControllerAnimatedTransition.Type {
        return WZViewControllerAnimatedTransition.self
    }
    
    public var wz_gestureRecognizerDelegateClass:WZViewGestureRecognizerDelegate.Type {
        return WZViewGestureRecognizerDelegate.self
    }
    
    public var wz_pushAnimatedType:WZViewControllerPushAnimatedType {
        return .push
    }
    
    public var wz_popAnimatedOptionsInfo:WZViewControllerPopAnimatedOptionsInfo {
        return WZViewControllerDefaultPopAnimatedOptionsInfo
    }
    
    public var wz_navigationController:WZRootNavigationController? {
        var vc:UIViewController? = self
        while vc != nil && ( vc is WZRootNavigationController ) == false {
            vc = vc?.navigationController
        }
        return vc as? WZRootNavigationController
    }
    
    public var wz_interactivePopDisabled:Bool {
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
    
    public var wz_prefersNavigationBarHidden:Bool {
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
}

extension UIViewController:WZExtensionsProvider{}
