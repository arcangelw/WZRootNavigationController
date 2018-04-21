//
//  WZContainerNavigationController.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit

public final class WZContainerNavigationController: UINavigationController {

    public convenience override init(rootViewController: UIViewController) {
        self.init(navigationBarClass: rootViewController.wz_navigationBarClass, toolbarClass: nil)
        pushViewController(rootViewController, animated: false)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
        interactivePopGestureRecognizer?.isEnabled = false
        if let navigationController = wz_navigationController , navigationController.isTransferNavigationBarAttributes == true {
            navigationBar.isTranslucent = navigationController.navigationBar.isTranslucent
            navigationBar.tintColor = navigationController.navigationBar.tintColor
            navigationBar.barTintColor = navigationController.navigationBar.barTintColor
            navigationBar.barStyle = navigationController.navigationBar.barStyle
            navigationBar.backgroundColor = navigationController.navigationBar.backgroundColor
            navigationBar.titleTextAttributes = navigationController.navigationBar.titleTextAttributes
            navigationBar.shadowImage = navigationController.navigationBar.shadowImage
            navigationBar.backIndicatorImage = navigationController.navigationBar.backIndicatorImage
            navigationBar.backIndicatorTransitionMaskImage = navigationController.navigationBar.backIndicatorTransitionMaskImage
        navigationBar.setTitleVerticalPositionAdjustment(navigationController.navigationBar.titleVerticalPositionAdjustment(for: .default), for: .default)
        navigationBar.setBackgroundImage(navigationController.navigationBar.backgroundImage(for: .default), for: .default)
            
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
        if let navigationController = self.navigationController {
            return navigationController.popViewController(animated:animated)
        }
        return super.popViewController(animated: animated)
    }
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if let navigationController = self.navigationController {
            return navigationController.popToRootViewController(animated:animated)
        }
        return super.popToRootViewController(animated: animated)
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if let navigationController = self.navigationController {
            return navigationController.popToViewController(viewController ,animated:animated)
        }
        return super.popToViewController(viewController ,animated:animated)
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
//                super.delegate = newValue
            }
        }
        get{
            return self.navigationController?.delegate// ?? super.delegate
        }
    }
    
    public override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        super.setNavigationBarHidden(hidden, animated: animated)
        if let visibleViewController = self.visibleViewController ,visibleViewController.wz_interactivePopDisabled == false {
            var visibleViewController = visibleViewController
            visibleViewController.wz_interactivePopDisabled = hidden
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
    public override func prefersHomeIndicatorAutoHidden() -> Bool {
        return self.topViewController?.prefersHomeIndicatorAutoHidden() ?? super.prefersHomeIndicatorAutoHidden()
    }
    
    @available(iOS 11.0, *)
    public override func childViewControllerForHomeIndicatorAutoHidden() -> UIViewController? {
        return self.topViewController ?? super.childViewControllerForHomeIndicatorAutoHidden()
    }
    
}


