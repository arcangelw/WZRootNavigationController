//
//  WZPageTransitionAnimation.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 arcangelw All rights reserved.
//

import UIKit

open class WZPageTransitionAnimation: NSObject,WZViewControllerAnimatedTransitioning {
    
    open var interactiveTransition: UIPercentDrivenInteractiveTransition?
    open var operation: UINavigationControllerOperation
    open weak var transitionContext: UIViewControllerContextTransitioning?
    public var isHidesBottomBar = true
    
    fileprivate lazy var maskView: UIView = {
        let maskView = UIView(frame: UIScreen.main.bounds)
        maskView.backgroundColor = UIColor.black
        return maskView
    }()
    
    public override init() {
        operation = .none
        super.init()
    }
    
    #if WZDEBUG
    deinit {
        print(self.classForCoder, #line , #function)
    }
    #endif
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        guard var from = transitionContext.viewController(forKey: .from) as? WZContainerController,
            var to = transitionContext.viewController(forKey: .to) as? WZContainerController
            else {
                assert(false, "transitionContext .from/.to 必须是 WZContainerController")
                if let toVC = transitionContext.viewController(forKey: .to)  {
                    toVC.view.frame = transitionContext.containerView.bounds
                    transitionContext.containerView.addSubview(toVC.view)
                }
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.backgroundColor = .black
        
        var startPositionX: CGFloat = UIScreen.main.bounds.width
        var endPositionX: CGFloat = 0
        
        var startOpacity: Float = 0
        var endOpacity: Float = 0.3
        
        var transformBackup = from.view.layer.transform
        
        var startTransform3D: CATransform3D = CATransform3DIdentity
        startTransform3D.m34 = -1.0/500.0
        var endTransform3D: CATransform3D = CATransform3DTranslate(startTransform3D, 0, 0, -35)
        
        if operation == .pop {
            swap(&from, &to)
            swap(&startPositionX, &endPositionX)
            swap(&startOpacity, &endOpacity)
            swap(&startTransform3D, &endTransform3D)
        } else {
            from.wz_tabbarSnapshot = from.wz_getTabbarSnapshot()
        }
        
        if let tabbarSnapshot = from.wz_tabbarSnapshot {
            from.view.addSubview(tabbarSnapshot)
        }
        containerView.addSubview(from.view)
        containerView.addSubview(to.view)
        from.view.addSubview(maskView)
        
        from.view.layer.transform = startTransform3D
        maskView.layer.opacity = startOpacity
        to.view.layer.position.x = startPositionX + to.view.layer.bounds.width / 2
        var shadowOpacityBackup = to.view.layer.shadowOpacity
        var shadowOffsetBackup = to.view.layer.shadowOffset
        var shadowRadiusBackup = to.view.layer.shadowRadius
        var shadowPathBackup = to.view.layer.shadowPath
        let tabbarhiddenBackup = from.navigationController?.tabBarController?.tabBar.isHidden
        to.view.layer.shadowOpacity = 0.5
        to.view.layer.shadowOffset = CGSize(width: -3, height: 0)
        to.view.layer.shadowRadius = 5
        to.view.layer.shadowPath = CGPath(rect: to.view.layer.bounds, transform: nil)
        if operation == .push {
            from.navigationController?.tabBarController?.tabBar.isHidden = to.hidesBottomBarWhenPushed
        }
        else if operation == .pop {
            from.navigationController?.tabBarController?.tabBar.isHidden = self.isHidesBottomBar
        }
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            self.maskView.layer.opacity = endOpacity
            from.view.layer.transform = endTransform3D
            to.view.layer.position.x = endPositionX + to.view.layer.bounds.width / 2
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if let `tabbarhiddenBackup` = tabbarhiddenBackup {
                from.navigationController?.tabBarController?.tabBar.isHidden = tabbarhiddenBackup
            }
            if let tabbarSnapshot = from.wz_tabbarSnapshot {
                tabbarSnapshot.removeFromSuperview()
            }
            self.maskView.removeFromSuperview()
            from.view.layer.transform = transformBackup
            if !transitionContext.transitionWasCancelled {
                to.view.layer.shadowOpacity = 0
                if finished {
                    to.view.layer.shadowOpacity = shadowOpacityBackup
                    to.view.layer.shadowOffset = shadowOffsetBackup
                    to.view.layer.shadowRadius = shadowRadiusBackup
                    to.view.layer.shadowPath = shadowPathBackup
                    if let tabBarController = to.navigationController?.tabBarController {
                        self.isHidesBottomBar = !tabBarController.tabBar.wz_isContains(inView:tabBarController.view)
                    }
                }
            }
        }
    }
}
