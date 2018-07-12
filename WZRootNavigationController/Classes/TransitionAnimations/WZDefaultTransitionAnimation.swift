//
//  WZPageTransitionAnimation.swift
//
//  Created by 吴哲 on 2018/5/7.
//  Copyright © 2018年 arcangelw. All rights reserved.
//  

import UIKit

open class WZDefaultTransitionAnimation:NSObject,WZViewControllerAnimatedTransitioning {

    open var interactiveTransition:UIPercentDrivenInteractiveTransition?
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
        
        var fromStartPx:CGFloat = 0.0
        var fromEndPx:CGFloat = -UIScreen.main.bounds.width * 0.618 //视差设置
        var toStartPx:CGFloat = UIScreen.main.bounds.width
        var toEndPx:CGFloat = 0.0
        var startOpacity:Float = 0.0
        var endOpacity:Float = 0.3
        
        if operation == .pop {
            swap(&from, &to)
            swap(&fromStartPx, &fromEndPx)
            swap(&toStartPx, &toEndPx)
            swap(&startOpacity, &endOpacity)
        }
        else if operation == .push {
            from.wz_tabbarSnapshot = from.wz_getTabbarSnapshot()
        }
        
        if let tabbarSnapshot = from.wz_tabbarSnapshot {
            from.view.addSubview(tabbarSnapshot)
        }
        containerView.addSubview(from.view)
        containerView.addSubview(to.view)
        from.view.addSubview(maskView)
        
        maskView.layer.opacity = startOpacity
        from.view.layer.position.x = fromStartPx + from.view.layer.bounds.width / 2.0
        to.view.layer.position.x = toStartPx + to.view.layer.bounds.width / 2.0
        let shadowOpacityBackup = to.view.layer.shadowOpacity
        let shadowOffsetBackup = to.view.layer.shadowOffset
        let shadowRadiusBackup = to.view.layer.shadowRadius
        let shadowPathBackup = to.view.layer.shadowPath
        let tabbarhiddenBackup = from.navigationController?.tabBarController?.tabBar.isHidden
        to.view.layer.shadowOpacity = 0.5
        to.view.layer.shadowOffset = CGSize(width: -3.0, height: 0.0)
        to.view.layer.shadowRadius = 5.0
        to.view.layer.shadowPath = CGPath(rect: to.view.layer.bounds, transform: nil)
        if operation == .push {
            from.navigationController?.tabBarController?.tabBar.isHidden = to.hidesBottomBarWhenPushed
        }
        else if operation == .pop {
            from.navigationController?.tabBarController?.tabBar.isHidden = self.isHidesBottomBar
        }
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.maskView.layer.opacity = endOpacity
            from.view.layer.position.x = fromEndPx + from.view.layer.bounds.width / 2.0
            to.view.layer.position.x = toEndPx + to.view.layer.bounds.width / 2.0
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if let `tabbarhiddenBackup` = tabbarhiddenBackup {
                from.navigationController?.tabBarController?.tabBar.isHidden = tabbarhiddenBackup
            }
            if let tabbarSnapshot = from.wz_tabbarSnapshot {
                tabbarSnapshot.removeFromSuperview()
            }
            self.maskView.removeFromSuperview()
            if !transitionContext.transitionWasCancelled {
                to.view.layer.shadowOpacity = 0.0
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
