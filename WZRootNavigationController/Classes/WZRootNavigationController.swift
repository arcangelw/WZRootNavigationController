//
//  WZRootNavigationController.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit

@IBDesignable
open class WZRootNavigationController: UINavigationController {
    
    /// 是否使用系统返回按钮 默认 false 不使用
    @IBInspectable open var isUseSystemBackBarButtonItem:Bool = false
    
    /// 是否转移导航栏属性 默认 ture 使用
    @IBInspectable open var isTransferNavigationBarAttributes:Bool = true
    
    private weak var wz_delegate:UINavigationControllerDelegate?
    
    private var animationCompletion: ((Bool) -> Void)?
    
    public override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        commonInit()
    }
    
    public init(rootViewControllerNoWrapping rootViewController: UIViewController!){
        super.init(rootViewController: WZContainerController(contentController: rootViewController))
        commonInit()
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: WZSafeWrapViewController(rootViewController))
        commonInit()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.viewControllers = super.viewControllers
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit(){}
    
    open override func viewDidLoad() {
        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = nil
        interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = .white
        super.delegate = self
        super.setNavigationBarHidden(true, animated: false)
    }
}

extension WZRootNavigationController {
    
    public var wz_visibleViewController:UIViewController? {
        guard let controller = super.visibleViewController else { return nil }
        return WZSafeUnwrapViewController(controller)
    }
    
    public var wz_topViewController:UIViewController? {
        guard let controller = super.topViewController else { return nil }
        return WZSafeUnwrapViewController(controller)
    }
    
    public var wz_viewControllers:[UIViewController] {
        return super.viewControllers.map({WZSafeUnwrapViewController($0)})
    }
    
    public func remove(viewController:UIViewController, animated:Bool = false){
        guard let toRemoveController = self.viewControllers.first(where: {WZSafeUnwrapViewController($0) == viewController}) else {
            return
        }
        let controllers = self.viewControllers.filter({$0 != toRemoveController})
        self.setViewControllers(controllers, animated: animated)
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping ((Bool) -> Void)){
        if let animationCompletion = self.animationCompletion {
           animationCompletion(false)
        }
        self.animationCompletion = completion
        self.pushViewController(viewController, animated: animated)
    }
    
    public func popViewController(animated: Bool, completion: @escaping ((Bool) -> Void)) -> UIViewController? {
        if let animationCompletion = self.animationCompletion {
            animationCompletion(false)
        }
        self.animationCompletion = completion
        if let vc = self.popViewController(animated: animated) {
            if let animationCompletion = self.animationCompletion {
                animationCompletion(true)
                self.animationCompletion = nil
            }
            return vc
        }
        return nil
    }
    
    public func popToRootViewController(animated: Bool, completion: @escaping ((Bool) -> Void)) -> [UIViewController]? {
        if let animationCompletion = self.animationCompletion {
            animationCompletion(false)
        }
        self.animationCompletion = completion
        if let array = self.popToRootViewController(animated: animated) {
            if let animationCompletion = self.animationCompletion , array.count == 0 {
                animationCompletion(true)
                self.animationCompletion = nil
            }
           return array
        }
        return nil
    }
    
    public func popToViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping ((Bool) -> Void)) -> [UIViewController]? {
        if let animationCompletion = self.animationCompletion {
            animationCompletion(false)
        }
        self.animationCompletion = completion
        if let array = self.popToViewController(viewController, animated: animated) {
            if let animationCompletion = self.animationCompletion , array.count == 0 {
                animationCompletion(true)
                self.animationCompletion = nil
            }
            return array
        }
        return nil
    }

}

extension WZRootNavigationController {
    
    open override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) { }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            let currentLast = WZSafeUnwrapViewController(self.viewControllers.last!)
            super.pushViewController(WZSafeWrapViewController(viewController, withPlaceholderController: self.isUseSystemBackBarButtonItem, backBarButtonItem: currentLast.navigationItem.backBarButtonItem, backTitle:currentLast.navigationItem.title ?? currentLast.title), animated: animated)
            
        }else{
            super.pushViewController(WZSafeWrapViewController(viewController), animated: animated)
        }
    }
    
    open override func popViewController(animated: Bool) -> UIViewController? {
        guard let controller = super.popViewController(animated: animated) else { return nil }
        return WZSafeUnwrapViewController(controller)
    }
    
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: animated)?.map({WZSafeUnwrapViewController($0)})
    }
    
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard let controllerToPop = super.viewControllers.first(where: {WZSafeUnwrapViewController($0) == viewController }) else { return nil }
        return super.popToViewController(controllerToPop, animated: animated)?.map({WZSafeUnwrapViewController($0)})
    }
    
    open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers.reduce([WZContainerController](), {[weak self] in
            guard let `self` = self else { return [] }
            if self.isUseSystemBackBarButtonItem && $0.count > 0 {
               let previous = WZSafeUnwrapViewController(viewControllers[$0.count - 1])
               let backItem = previous.navigationItem.backBarButtonItem
               let backTitle = previous.navigationItem.title ?? previous.title
               if let container = $1 as? WZContainerController {
                    if let placeholderController = container.containerNavigationController?.realViewControllers.first,
                        placeholderController != container.contentViewController{
                        let noChange = placeholderController.navigationItem.backBarButtonItem == backItem && placeholderController.navigationItem.title == backTitle && placeholderController.title == backTitle
                        placeholderController.navigationItem.backBarButtonItem = backItem
                        placeholderController.navigationItem.title = backTitle
                        placeholderController.title = backTitle
                        if !noChange {
                            container.containerNavigationController!.realViewControllers = [placeholderController,container.contentViewController]
                        }
                    }
               }
               return $0 + [WZSafeWrapViewController($1, withPlaceholderController: self.isUseSystemBackBarButtonItem, backBarButtonItem: backItem, backTitle:backTitle)]
            }
            if let container = $1 as? WZContainerController {
                container.containerNavigationController?.realViewControllers = [container.contentViewController]
                if $0.count == 0 && container.navigationItem.leftBarButtonItem?.tag == self.hashValue {
                    container.navigationItem.leftBarButtonItem = nil
                }
            }
            return $0 + [WZSafeWrapViewController($1)]
        }), animated: animated)
    }
    
    open override var delegate: UINavigationControllerDelegate?{
        set{
            self.wz_delegate = newValue
        }
        get{
            return super.delegate
        }
    }
    
    open override var shouldAutorotate: Bool {
        return self.topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.topViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }
    
    open override func responds(to aSelector: Selector!) -> Bool {
        if super.responds(to: aSelector) {
            return true
        }
        return self.wz_delegate?.responds(to: aSelector) ?? false
    }
    
    open override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return self.wz_delegate
    }
}

// MARK: unwind
extension WZRootNavigationController {
    
    open override func forUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any?) -> UIViewController? {
        if let controller = super.forUnwindSegueAction(action, from: fromViewController, withSender: sender){
            return controller
        }
        guard let from = fromViewController as? WZContainerController ?? self.viewControllers.first(where: {WZSafeUnwrapViewController($0) == fromViewController}) else { return nil}
        guard let fromIdx = self.viewControllers.index(of: from) ,fromIdx > 0 else { return nil }
        func uwind(idx:Int) -> UIViewController? {
            guard let controller = self.viewControllers[idx].forUnwindSegueAction(action, from: fromViewController, withSender: sender) else {
                return idx == 0 ? nil : uwind(idx: idx - 1)
            }
            return controller
        }
        return uwind(idx: fromIdx - 1)
    }
}

// MARK: UINavigationControllerDelegate
extension WZRootNavigationController: UINavigationControllerDelegate {
    
    @objc func wz_onBack(){
       let _ = popViewController(animated: true)
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let containerController = viewController as? WZContainerController else {
            return
        }
        let isRoot = containerController == navigationController.viewControllers.first
        let contentViewController = WZSafeUnwrapViewController(viewController)
        contentViewController.navigationController?.setNavigationBarHidden(contentViewController.wz_prefersNavigationBarHidden, animated: false)
        if isRoot == false {
            let hasSetLeftItem = contentViewController.navigationItem.leftBarButtonItem != nil
            if !self.isUseSystemBackBarButtonItem && !hasSetLeftItem {
                if  let item = contentViewController.wz_customBackItem(withTarget: self, action: #selector(wz_onBack)) {
                    contentViewController.navigationItem.leftBarButtonItem = item
                }else{
                    contentViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Back", comment:""), style: .plain, target: self, action: #selector(wz_onBack))
                }
            }
            contentViewController.navigationItem.leftBarButtonItem?.tag = self.hashValue
        }
        self.wz_delegate?.navigationController?(navigationController, willShow: contentViewController, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let containerController = viewController as? WZContainerController else {
            return
        }
        let contentViewController = WZSafeUnwrapViewController(containerController)
        WZRootNavigationController.attemptRotationToDeviceOrientation()
        self.wz_delegate?.navigationController?(navigationController, didShow: contentViewController, animated: animated)
        if let animationCompletion = self.animationCompletion {
            animationCompletion(true)
            self.animationCompletion = nil
        }
    }
    
    public func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return self.wz_delegate?.navigationControllerSupportedInterfaceOrientations?(navigationController) ?? .all
    }
    
    public func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        return self.wz_delegate?.navigationControllerPreferredInterfaceOrientationForPresentation?(navigationController) ?? .portrait
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.wz_delegate?.navigationController?(navigationController, interactionControllerFor:animationController) ?? (animationController as? WZAnimatedTransitionPlugin)?.fromViewController.interactiveTransition
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let from = fromVC as? WZContainerController ,let to = toVC as? WZContainerController else { return nil }
        if let transition = self.wz_delegate?.navigationController?(navigationController, animationControllerFor: operation, from: from, to: to) {
            return transition
        }
        return WZSafeUnwrapViewController(from).wz_animatedTransitionPluginClass.init(operation: operation, from: from, to: to)
    }

}
