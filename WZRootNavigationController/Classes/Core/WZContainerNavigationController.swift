//
//  WZContainerNavigationController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/20.
//  Copyright © 2018年 arcangelw All rights reserved.
//

import UIKit

public final class WZContainerNavigationController: UINavigationController {

    public convenience override init(rootViewController: UIViewController) {
        self.init(navigationBarClass: rootViewController.wz_navigationBarClass, toolbarClass: nil)
        pushViewController(rootViewController, animated: false)
    }
    
    #if WZDEBUG
    deinit {
        print(self.classForCoder, #line , #function, ":", self.topViewController?.classForCoder ?? "")
    }
    #endif
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
        interactivePopGestureRecognizer?.isEnabled = false
        /// self.topViewController?.wz_navigationBarClass == nil
        /// 当前自定义navigationBar的时候 不转移导航栏属性
        if let navigationController = wz_navigationController , navigationController.isTransferNavigationBarAttributes == true , self.topViewController?.wz_navigationBarClass == nil {
            navigationBar.backgroundColor = navigationController.navigationBar.backgroundColor
            navigationBar.barStyle = navigationController.navigationBar.barStyle
            navigationBar.isTranslucent = navigationController.navigationBar.isTranslucent
            navigationBar.tintColor = navigationController.navigationBar.tintColor
            navigationBar.barTintColor = navigationController.navigationBar.barTintColor
            navigationBar.shadowImage = navigationController.navigationBar.shadowImage
            navigationBar.titleTextAttributes = navigationController.navigationBar.titleTextAttributes
            navigationBar.backIndicatorImage = navigationController.navigationBar.backIndicatorImage
            navigationBar.backIndicatorTransitionMaskImage = navigationController.navigationBar.backIndicatorTransitionMaskImage
            if #available(iOS 11.0, *) {
                navigationBar.prefersLargeTitles = navigationController.navigationBar.prefersLargeTitles
                navigationBar.largeTitleTextAttributes = navigationController.navigationBar.largeTitleTextAttributes
            }
        navigationBar.setBackgroundImage(navigationController.navigationBar.backgroundImage(for: .default), for: .default)
        navigationBar.setTitleVerticalPositionAdjustment(navigationController.navigationBar.titleVerticalPositionAdjustment(for: .default), for: .default)
        
            
        }
        view.layoutIfNeeded()
    }
 
}

extension WZContainerNavigationController {
    
    public override var tabBarController: UITabBarController? {
        guard let tabController = super.tabBarController ,let navigationController = wz_navigationController else {
            return nil
        }
        if navigationController.tabBarController != tabController {
            return tabController
        }else{
            return ( !tabController.tabBar.isTranslucent || navigationController.wz_viewControllers.contains{$0.hidesBottomBarWhenPushed} ) ? nil : tabController
        }
    }
    
    public override var viewControllers: [UIViewController] {
        set {
            super.viewControllers = newValue
        }
        get{
            guard let navigationController = self.navigationController as? WZRootNavigationController else {
                return super.viewControllers
            }
            return navigationController.wz_viewControllers
        }
    }
    
    public var realViewControllers: [UIViewController] {
        set{
            super.popToRootViewController(animated: false)
            super.setViewControllers(newValue, animated: false)
        }
        get{
            return super.viewControllers
        }
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: animated)
        }else{
            super.pushViewController(viewController, animated: animated)
        }
    }
    
    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        guard let navigationController = self.navigationController ,navigationController.responds(to: aSelector) else { return nil}
        return navigationController
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        return self.navigationController?.popViewController(animated: animated) ?? super.popViewController(animated: animated)
    }
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return self.navigationController?.popToRootViewController(animated: animated) ?? super.popToRootViewController(animated: animated)
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return self.navigationController?.popToViewController(viewController, animated: animated) ?? super.popToViewController(viewController ,animated:animated)
    }
    
    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.setViewControllers(viewControllers, animated: animated)
        }else{
            super.setViewControllers(viewControllers, animated: animated)
        }
    }
    
    public override var delegate: UINavigationControllerDelegate? {
        set {
            if let navigationController = self.navigationController {
                navigationController.delegate = newValue
            }else{
                super.delegate = newValue
            }
        }
        get{
            return self.navigationController?.delegate ?? super.delegate
        }
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    public override var prefersStatusBarHidden: Bool {
        return self.topViewController?.prefersStatusBarHidden ?? super.prefersStatusBarHidden
    }
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return self.topViewController?.preferredStatusBarUpdateAnimation ?? super.preferredStatusBarUpdateAnimation
    }
    
    
    @available(iOS 11.0, *)
    public override func childViewControllerForScreenEdgesDeferringSystemGestures() -> UIViewController? {
        return topViewController
    }
    
    @available(iOS 11.0, *)
    public override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return topViewController?.preferredScreenEdgesDeferringSystemGestures() ?? []
    }
    
    @available(iOS 11.0, *)
    public override func prefersHomeIndicatorAutoHidden() -> Bool {
        return self.topViewController?.prefersHomeIndicatorAutoHidden() ?? super.prefersHomeIndicatorAutoHidden()
    }
    
    @available(iOS 11.0, *)
    public override func childViewControllerForHomeIndicatorAutoHidden() -> UIViewController? {
        return self.topViewController
    }
    
}

// MARK: unwind
extension WZContainerNavigationController{
    
    public override func forUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any?) -> UIViewController? {
        if let navigationController = self.navigationController  {
            return navigationController.forUnwindSegueAction(action, from: fromViewController, withSender: sender)
        }
        return super.forUnwindSegueAction(action, from: fromViewController, withSender: sender)
    }
    
    @available(iOS 9.0, *)
    public override func allowedChildViewControllersForUnwinding(from source: UIStoryboardUnwindSegueSource) -> [UIViewController] {
        if let navigationController = self.navigationController {
            return navigationController.allowedChildViewControllersForUnwinding(from:source)
        }
        return super.allowedChildViewControllersForUnwinding(from: source)
    }
}


