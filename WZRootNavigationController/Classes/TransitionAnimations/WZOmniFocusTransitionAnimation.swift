//
//  WZOmniFocusTransitionAnimation.swift
//
//  Created by 吴哲 on 2018/5/7.
//  Copyright © 2018年 arcangelw. All rights reserved.
//  

import UIKit

open class WZOmniFocusTransitionAnimation:NSObject, WZViewControllerAnimatedTransitioning {
    
    open var interactiveTransition:UIPercentDrivenInteractiveTransition?
    open var operation: UINavigationControllerOperation
    open weak var transitionContext: UIViewControllerContextTransitioning?
    public var isHidesBottomBar = true
    
    open fileprivate(set) weak var keyView:UIView!
    open var bottomView:UIView = UIView()
    
    public init(key:UIView) {
        operation = .none
        keyView = key
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
        
        var topHeight:CGFloat = 0.0
        var bottomHeight = from.view.layer.bounds.height - topHeight
        if operation == .pop {
            swap(&from, &to)
            topHeight = from.view.bounds.height - bottomView.bounds.height
            bottomHeight = bottomView.bounds.height
        }
        else if operation == .push {
            from.wz_tabbarSnapshot = from.wz_getTabbarSnapshot()
        }
        if let tabbarSnapshot = from.wz_tabbarSnapshot {
            from.view.addSubview(tabbarSnapshot)
        }
        
        let positionyBackup:CGFloat = from.view.layer.position.y
        let fromView = from.navigationController?.tabBarController?.view
        
        if operation == .push {
            
            topHeight = containerView.convert(keyView.layer.position, from: keyView.superview).y + keyView.layer.bounds.height / 2.0
            bottomHeight = (fromView ?? from.view).layer.bounds.height - topHeight
            
            bottomView.frame = CGRect(x: 0.0, y: topHeight, width: (fromView ?? from.view).layer.bounds.width, height: bottomHeight)
            bottomView.layer.contents = {
                let scale = UIScreen.main.scale
                UIGraphicsBeginImageContextWithOptions((fromView ?? from.view).bounds.size, true, scale)
                guard let context = UIGraphicsGetCurrentContext() else {
                    return nil
                }
                (fromView ?? from.view).layer.render(in:context)
                let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
                UIGraphicsEndImageContext()
                let inRect = CGRect(x: 0.0, y: topHeight * scale, width: from.view.layer.bounds.width * scale, height: bottomHeight * scale)
                let clip = image.cgImage?.cropping(to: inRect)
                return clip
            }()
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(rect: CGRect(x: 0.0, y: 0.0, width: (fromView ?? from.view).layer.bounds.width, height: topHeight)).cgPath
            from.view.layer.mask = maskLayer
        }
        else if operation == .pop{
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(rect: CGRect(x: 0.0, y: 0.0, width: (fromView ?? from.view).layer.bounds.width, height: topHeight)).cgPath
            from.view.layer.mask = maskLayer
            from.view.layer.position.y -= topHeight
            topHeight = -topHeight
            bottomHeight = -bottomHeight
        }
        containerView.addSubview(to.view)
        containerView.addSubview(from.view)
        containerView.addSubview(bottomView)
        
        let tabbarhiddenBackup = from.navigationController?.tabBarController?.tabBar.isHidden
        if operation == .push {
            from.navigationController?.tabBarController?.tabBar.isHidden = to.hidesBottomBarWhenPushed
        }
        else if operation == .pop {
            from.navigationController?.tabBarController?.tabBar.isHidden = isHidesBottomBar
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn,.curveEaseOut], animations: {
            from.view.layer.position.y -= topHeight
            self.bottomView.layer.position.y += bottomHeight
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if let `tabbarhiddenBackup` = tabbarhiddenBackup {
                from.navigationController?.tabBarController?.tabBar.isHidden = tabbarhiddenBackup
            }
            if let tabbarSnapshot = from.wz_tabbarSnapshot {
                tabbarSnapshot.removeFromSuperview()
            }
            if let tabBarController = to.navigationController?.tabBarController {
                self.isHidesBottomBar = !tabBarController.tabBar.wz_isContains(inView:tabBarController.view)
            }
            self.bottomView.removeFromSuperview()
            from.view.layer.position.y = positionyBackup
            from.view.layer.mask = nil
            to.view.layer.mask = nil
        }
    }
}
