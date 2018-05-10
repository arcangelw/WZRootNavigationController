//
//  WZContainerController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/20.
//  Copyright © 2018年 arcangelw All rights reserved.
//

import UIKit

public func WZSafeUnwrapViewController(_ controller:UIViewController) ->UIViewController {
    guard let _controller = controller as? WZContainerController else { return controller }
    return _controller.contentViewController
}

public func WZSafeWrapViewController(_ controller:UIViewController ,withPlaceholderController yesOrNo:Bool = false ,backBarButtonItem backItem:UIBarButtonItem? = nil ,backTitle:String? = nil) ->WZContainerController{
    if controller is WZContainerController { return controller as! WZContainerController }
    return WZContainerController(controller: controller, withPlaceholderController: yesOrNo, backBarButtonItem: backItem, backTitle: backTitle)
}

@objc public final class WZContainerController: UIViewController {
    
    @objc public fileprivate(set) var contentViewController:UIViewController
    
    public let containerNavigationController:WZContainerNavigationController?
    
    init(controller:UIViewController ,withPlaceholderController yesOrNo:Bool = false ,backBarButtonItem backItem:UIBarButtonItem? = nil ,backTitle:String? = nil) {
        self.contentViewController = controller
        self.containerNavigationController = WZContainerNavigationController(navigationBarClass: controller.wz_navigationBarClass, toolbarClass: nil)
        super.init(nibName: nil, bundle: nil)
        
        if yesOrNo {
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            vc.title = backTitle
            vc.navigationItem.title = backTitle
            vc.navigationItem.backBarButtonItem = backItem
            containerNavigationController!.viewControllers = [vc,controller]
        }else{
            containerNavigationController!.viewControllers = [controller]
        }
        addChildViewController(containerNavigationController!)
        containerNavigationController!.didMove(toParentViewController: self)
    }
    
    init(contentController controller:UIViewController) {
        self.contentViewController = controller
        self.containerNavigationController = nil
        super.init(nibName: nil, bundle: nil)
        addChildViewController(contentViewController)
        contentViewController.didMove(toParentViewController: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if WZDEBUG
    deinit {
        print(self.classForCoder, #line , #function, ":", self.contentViewController.classForCoder)
    }
    #endif
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let containerNavigationController = self.containerNavigationController {
            containerNavigationController.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            containerNavigationController.view.frame = view.bounds
            view.addSubview(containerNavigationController.view)
        }else{
            contentViewController.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            contentViewController.view.frame = view.bounds
            view.addSubview(contentViewController.view)
        }
        
        wz_popGestureProcessing.container = self
        if self.navigationController?.viewControllers.first == self {
            contentViewController.wz_popEdge = []
        }
    }
}

extension WZContainerController {
    
    /// WZContainerController 获取真实的控制器
    @objc public  static func safeUnwrapViewController(_ controller:UIViewController) -> UIViewController{
        return WZSafeUnwrapViewController(controller)
    }
    
    /// 包装控制器为 WZContainerController
    @objc public static func safeWrapViewController(_ controller:UIViewController ,withPlaceholderController yesOrNo:Bool = false ,backBarButtonItem backItem:UIBarButtonItem? = nil ,backTitle:String? = nil) -> WZContainerController{
        return WZSafeWrapViewController(controller, withPlaceholderController:yesOrNo, backBarButtonItem:backItem, backTitle:backTitle)
    }
}

extension WZContainerController{
    public override var wz_rootContentConfig: WZRootContentConfigProtocol{
        get {return contentViewController.wz_rootContentConfig }
        set {contentViewController.wz_rootContentConfig = newValue}
    }
}

extension WZContainerController {
    
    public override var canBecomeFirstResponder: Bool {
        return contentViewController.canBecomeFirstResponder
    }
    
    public override func becomeFirstResponder() -> Bool {
        return contentViewController.becomeFirstResponder()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return contentViewController.preferredStatusBarStyle
    }
    
    public override var prefersStatusBarHidden: Bool {
        return contentViewController.prefersStatusBarHidden
    }
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return contentViewController.preferredStatusBarUpdateAnimation
    }
    
    public override var shouldAutorotate: Bool {
        return contentViewController.shouldAutorotate
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return contentViewController.supportedInterfaceOrientations
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return contentViewController.preferredInterfaceOrientationForPresentation
    }
    
    public override var hidesBottomBarWhenPushed: Bool {
        set{
            contentViewController.hidesBottomBarWhenPushed = newValue
        }
        get{
            return contentViewController.hidesBottomBarWhenPushed
        }
    }
   
    public override var title: String? {
        set{
            contentViewController.title = newValue
        }
        get{
            return contentViewController.title
        }
    }
    
    public override var tabBarItem: UITabBarItem! {
        set{
            contentViewController.tabBarItem = newValue
        }
        get{
            return contentViewController.tabBarItem
        }
    }
    
    @available(iOS 11.0, *)
    public override func childViewControllerForScreenEdgesDeferringSystemGestures() -> UIViewController? {
        return contentViewController
    }
    
    @available(iOS 11.0, *)
    public override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return contentViewController.preferredScreenEdgesDeferringSystemGestures()
    }
    
    @available(iOS 11.0, *)
    public override func prefersHomeIndicatorAutoHidden() -> Bool {
        return contentViewController.prefersHomeIndicatorAutoHidden()
    }
    
    @available(iOS 11.0, *)
    public override func childViewControllerForHomeIndicatorAutoHidden() -> UIViewController? {
        return contentViewController
    }
}

// MARK: unwind
extension WZContainerController{
    
    public override func forUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any?) -> UIViewController? {
        return contentViewController.forUnwindSegueAction(action ,from: fromViewController, withSender:sender)
    }
}
