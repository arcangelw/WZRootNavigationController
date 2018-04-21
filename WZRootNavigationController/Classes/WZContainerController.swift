//
//  WZContainerController.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit

internal func WZSafeUnwrapViewController(_ controller:UIViewController) ->UIViewController {
    guard let _controller = controller as? WZContainerController else { return controller}
    return _controller.contentViewController
}

internal func WZSafeWrapViewController(_ controller:UIViewController ,withPlaceholderController yesOrNo:Bool = false ,backBarButtonItem backItem:UIBarButtonItem? = nil ,backTitle:String? = nil) ->UIViewController{
    if controller is WZContainerController { return controller }
    return WZContainerController(controller: controller, withPlaceholderController: yesOrNo, backBarButtonItem: backItem, backTitle: backTitle)
}

public final class WZContainerController: UIViewController {

    private(set) var interactiveTransition:UIPercentDrivenInteractiveTransition?
    
    public fileprivate(set) var contentViewController:UIViewController
    
    public let containerNavigationController:WZContainerNavigationController?
    
    private var popRecognizerDelegate:UIGestureRecognizerDelegate?
    
    init(controller:UIViewController ,withPlaceholderController yesOrNo:Bool = false ,backBarButtonItem backItem:UIBarButtonItem? = nil ,backTitle:String? = nil) {
        self.contentViewController = controller
        self.containerNavigationController = WZContainerNavigationController(navigationBarClass: controller.wz_navigationBarClass, toolbarClass: nil)
        super.init(nibName: nil, bundle: nil)
        
        if yesOrNo {
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            vc.title = backTitle
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
        view.addGestureRecognizer(popRecognizer)
        popRecognizerDelegate = contentViewController.wz_gestureRecognizerDelegateClass.init(containerController: self, contentViewController: contentViewController)
        popRecognizer.delegate = popRecognizerDelegate

        if self.navigationController?.viewControllers.first == self {
            contentViewController.wz_interactivePopDisabled = true
        }
    }
}

extension WZContainerController {
    @objc func handlePopRecognizer(_ recognizer:UIPanGestureRecognizer){
        var progress = recognizer.translation(in: self.view).x / self.view.frame.width
        progress = min(1.0, max(0.0, progress))
        
        if .began == recognizer.state {
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
