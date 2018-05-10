//
//  WZRootTransitionAnimation.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/5/10.
//  Copyright © 2018年 arcangelw All rights reserved.
//  转场动画来自
//  https://github.com/DianQK/TransitionTreasury/blob/master/TransitionAnimation/TRTransitionAnimations.swift

import UIKit

/// 基础转场动画
public enum WZRootTransitionAnimationType{
    /// `default`
    case `default`
    /// Page Motion
    case page
    /// Fade Out In
    case fadeOut
    /// Like OmniFocus
    case omniFocus(keyView:UIView)
    /// custom
    case custom(animation:WZViewControllerAnimatedTransitioning)
    
    var animation:WZViewControllerAnimatedTransitioning {
        switch self {
        case .default:
            return WZDefaultTransitionAnimation()
        case .page:
            return WZPageTransitionAnimation()
        case .fadeOut:
            return WZFadeOutTransitionAnimation()
        case .omniFocus(let key):
            return WZOmniFocusTransitionAnimation(key:key)
        case .custom(let animation):
            return animation
        }
    }
}
/// 为了兼容ObjC 和将基础动画提供给ObjC使用
@objc public final class WZRootTransitionAnimationProcess:NSObject,WZTransitionAnimationConvert{
    
    @objc public class var `defalut`:WZTransitionAnimationConvert {
      return WZRootTransitionAnimationProcess()
    }
    
    @objc public class var page:WZTransitionAnimationConvert {
        return WZRootTransitionAnimationProcess(type: .page)
    }
    
    @objc public class var fadeOut:WZTransitionAnimationConvert {
        return WZRootTransitionAnimationProcess(type: .fadeOut)
    }
    
    @objc public static func omniFocus(key:UIView)->WZRootTransitionAnimationProcess{
        return WZRootTransitionAnimationProcess(type: .omniFocus(keyView: key))
    }
    
    let animation:WZViewControllerAnimatedTransitioning
    
    public init(type:WZRootTransitionAnimationType = .default) {
        self.animation = type.animation
        super.init()
    }
    
    #if WZDEBUG
    deinit {
        print(self.classForCoder, #line , #function)
    }
    #endif
    
    public func convertTransitionAnimation() -> WZViewControllerAnimatedTransitioning {
        return animation
    }
}
