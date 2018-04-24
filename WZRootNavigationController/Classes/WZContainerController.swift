//
//  WZContainerController.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
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

public final class WZContainerController: UIViewController {

    fileprivate(set) var interactiveTransition:UIPercentDrivenInteractiveTransition?
    
    public fileprivate(set) var contentViewController:UIViewController
    
    public let containerNavigationController:WZContainerNavigationController?
    
    @objc public fileprivate(set) var gestureDirection:WZGestureDirection = .none
    
    public fileprivate(set) var popRecognizerDelegate:UIGestureRecognizerDelegate?
    
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
    
    #if DEBUG
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
        
//        let internalTargets = self.navigationController?.interactivePopGestureRecognizer?.value(forKey: "targets") as? Array<AnyObject>
//        let internalTarget = internalTargets?.first?.value(forKey: "target")
//        let internalAction = NSSelectorFromString("handleNavigationTransition:")
        
        let popRecognizer = UIPanGestureRecognizer(target: self, action:#selector(handlePopRecognizer(_:)))
        popRecognizer.maximumNumberOfTouches = 1
        popRecognizer.delaysTouchesBegan = true
        view.addGestureRecognizer(popRecognizer)
        popRecognizerDelegate = contentViewController.wz_gesturePluginClass.init(containerController: self)
        popRecognizer.delegate = popRecognizerDelegate

        if self.navigationController?.viewControllers.first == self {
            contentViewController.wz_interactivePopDisabled = true
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

extension WZContainerController {
    @objc func handlePopRecognizer(_ recognizer:UIPanGestureRecognizer){
        
        var progress:CGFloat =  0.0
        if self.gestureDirection.isHorizontal {
            progress = recognizer.translation(in: self.view).x / self.view.frame.width
        }else if self.gestureDirection.isVertical {
            progress = recognizer.translation(in: self.view).y / self.view.frame.height
        }else{
            if let interactiveTransition = self.interactiveTransition {
                interactiveTransition.cancel()
                self.interactiveTransition?.cancel()
                return
            }
        }
        progress = min(1.0, max(0.0, progress))
        if .began == recognizer.state {
            if self.interactiveTransition != nil && self.gestureDirection != .none { return }
            self.gestureDirection = recognizer.wz_direction(in: self.view)
            self.interactiveTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewController(animated: true)
        }
        else if .changed == recognizer.state , let interactiveTransition = self.interactiveTransition {
            interactiveTransition.update(progress)
        }
        else if (( .ended == recognizer.state ) || (.cancelled == recognizer.state)), let interactiveTransition = self.interactiveTransition {
            
            if progress > 0.2 {
                interactiveTransition.finish()
            }else{
                interactiveTransition.cancel()
            }
            self.gestureDirection = .none
            self.interactiveTransition = nil
        }else{
            self.gestureDirection = .none
            self.interactiveTransition = nil
        }
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
