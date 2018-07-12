//
//  WZFadeOutTransitionAnimation.swift
//
//  Created by 吴哲 on 2018/5/7.
//  Copyright © 2018年 arcangelw. All rights reserved.
//  

import UIKit

open class WZFadeOutTransitionAnimation:NSObject,WZViewControllerAnimatedTransitioning {
    
    open var interactiveTransition:UIPercentDrivenInteractiveTransition?
    open var operation: UINavigationControllerOperation
    open weak var transitionContext: UIViewControllerContextTransitioning?
    public var isHidesBottomBar = true
    
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
        return 0.3
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
        let duration = transitionDuration(using: transitionContext)
        
        var start:Float = 0.0
        var end:Float = 1.0
        if operation == .pop {
            swap(&from, &to)
            swap(&start, &end)
        }
        else if operation == .push {
            from.wz_tabbarSnapshot = from.wz_getTabbarSnapshot()
        }
        
        if let tabbarSnapshot = from.wz_tabbarSnapshot {
            from.view.addSubview(tabbarSnapshot)
        }
        containerView.addSubview(from.view)
        containerView.addSubview(to.view)
        to.view.layer.opacity = start
        let tabbarhiddenBackup = from.navigationController?.tabBarController?.tabBar.isHidden
        if operation == .push {
            from.navigationController?.tabBarController?.tabBar.isHidden = to.hidesBottomBarWhenPushed
        }
        else if operation == .pop {
            from.navigationController?.tabBarController?.tabBar.isHidden = isHidesBottomBar
        }
        UIView.animate(withDuration:duration, delay: 0, options: .curveEaseInOut, animations: {
            to.view.layer.opacity = end
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            to.view.layer.opacity = 1.0
            if let `tabbarhiddenBackup` = tabbarhiddenBackup {
                from.navigationController?.tabBarController?.tabBar.isHidden = tabbarhiddenBackup
            }
            if let tabbarSnapshot = from.wz_tabbarSnapshot {
                tabbarSnapshot.removeFromSuperview()
            }
            if let tabBarController = to.navigationController?.tabBarController {
                self.isHidesBottomBar = !tabBarController.tabBar.wz_isContains(inView:tabBarController.view)
            }
        }
    }
}
