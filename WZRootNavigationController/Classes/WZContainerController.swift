//
//  WZContainerController.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit

public final class WZContainerController: UIViewController {

    private(set) var interactiveTransition:UIPercentDrivenInteractiveTransition?
    
    public let contentViewController:WZExtensionsProvider
    
    public let containerNavigationController:WZContainerNavigationController?
    
//    private let gestureRecognizerDelegate:UIGestureRecognizerDelegate?
    
    init(controller:WZExtensionsProvider ,withPlaceholderController yesOrNo:Bool = false ,backBarButtonItem backItem:UIBarButtonItem? = nil ,backTitle:String? = nil) {
        self.contentViewController = controller
        self.containerNavigationController = WZContainerNavigationController(navigationBarClass: controller.wz_navigationBarClass, toolbarClass: nil)
//        self.gestureRecognizerDelegate = controller.gestureRecognizerDelegateClass.init() as? UIGestureRecognizerDelegate
        super.init(nibName: nil, bundle: nil)
        
        if yesOrNo {
            let vc = UIViewController()
            vc.title = backTitle
            vc.navigationItem.backBarButtonItem = backItem
            containerNavigationController!.viewControllers = [vc,controller as! UIViewController]
        }else{
            containerNavigationController!.viewControllers = [controller as! UIViewController]
        }
        addChildViewController(containerNavigationController!)
        containerNavigationController!.didMove(toParentViewController: self)
    }
    
    init(contentController controller:WZExtensionsProvider) {
        self.contentViewController = controller
        self.containerNavigationController = nil
//        self.gestureRecognizerDelegate = controller.gestureRecognizerDelegateClass.init() as? UIGestureRecognizerDelegate
        super.init(nibName: nil, bundle: nil)
        let contentViewController = self.contentViewController as! UIViewController
        addChildViewController(contentViewController)
        contentViewController.didMove(toParentViewController: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let containerNavigationController = self.containerNavigationController {
            containerNavigationController.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            containerNavigationController.view.frame = view.bounds
            view.addSubview(containerNavigationController.view)
        }else{
            let contentViewController = self.contentViewController as! UIViewController
            contentViewController.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            contentViewController.view.frame = view.bounds
            view.addSubview(contentViewController.view)
        }
        
        
    }
}


extension WZContainerController {
    var _contentViewController:UIViewController{
        return contentViewController as! UIViewController
    }
    
    public override func becomeFirstResponder() -> Bool {
        return _contentViewController.becomeFirstResponder()
    }
    
    public override var canBecomeFirstResponder: Bool {
        return _contentViewController.canBecomeFirstResponder
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return _contentViewController.preferredStatusBarStyle
    }
    
    public override var prefersStatusBarHidden: Bool {
        return _contentViewController.prefersStatusBarHidden
    }
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return _contentViewController.preferredStatusBarUpdateAnimation
    }
    
    public override var shouldAutorotate: Bool {
        return _contentViewController.shouldAutorotate
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return _contentViewController.supportedInterfaceOrientations
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return _contentViewController.preferredInterfaceOrientationForPresentation
    }
    
    public override var hidesBottomBarWhenPushed: Bool {
        set{
            _contentViewController.hidesBottomBarWhenPushed = newValue
        }
        get{
            return _contentViewController.hidesBottomBarWhenPushed
        }
    }
   
    public override var title: String? {
        set{
            _contentViewController.title = newValue
        }
        get{
            return _contentViewController.title
        }
    }
    
    public override var tabBarItem: UITabBarItem! {
        set{
            _contentViewController.tabBarItem = newValue
        }
        get{
            return _contentViewController.tabBarItem
        }
    }
}

@available(iOS 9.0, *)
extension WZContainerController{
    
    public override func allowedChildViewControllersForUnwinding(from source: UIStoryboardUnwindSegueSource) -> [UIViewController] {
        return _contentViewController.allowedChildViewControllersForUnwinding(from:source)
    }
}


@available(iOS 11.0, *)
extension WZContainerController{
    
    public override func prefersHomeIndicatorAutoHidden() -> Bool {
        return _contentViewController.prefersHomeIndicatorAutoHidden()
    }
    
    public override func childViewControllerForHomeIndicatorAutoHidden() -> UIViewController? {
        return _contentViewController.childViewControllerForHomeIndicatorAutoHidden()
    }
}
