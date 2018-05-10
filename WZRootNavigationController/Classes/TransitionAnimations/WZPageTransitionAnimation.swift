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
    
    fileprivate var transformBackup: CATransform3D?
    fileprivate var shadowOpacityBackup: Float?
    fileprivate var shadowOffsetBackup: CGSize?
    fileprivate var shadowRadiusBackup: CGFloat?
    fileprivate var shadowPathBackup: CGPath?
    
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
        
        transformBackup = transformBackup ?? from.view.layer.transform
        
        var transform3D: CATransform3D = CATransform3DIdentity
        transform3D.m34 = -1.0/500.0
        
        if operation == .pop {
            swap(&from, &to)
            swap(&startPositionX, &endPositionX)
            swap(&startOpacity, &endOpacity)
        } else {
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -35)
        }
        
        containerView.addSubview(from.view)
        containerView.addSubview(to.view)
        from.view.addSubview(maskView)
        
        maskView.layer.opacity = startOpacity
        to.view.layer.position.x = startPositionX + to.view.layer.bounds.width / 2
        shadowOpacityBackup = to.view.layer.shadowOpacity
        shadowOffsetBackup = to.view.layer.shadowOffset
        shadowRadiusBackup = to.view.layer.shadowRadius
        shadowPathBackup = to.view.layer.shadowPath
        to.view.layer.shadowOpacity = 0.5
        to.view.layer.shadowOffset = CGSize(width: -3, height: 0)
        to.view.layer.shadowRadius = 5
        to.view.layer.shadowPath = CGPath(rect: to.view.layer.bounds, transform: nil)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            self.maskView.layer.opacity = endOpacity
            from.view.layer.transform = transform3D
            to.view.layer.position.x = endPositionX + to.view.layer.bounds.width / 2
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if !transitionContext.transitionWasCancelled {
                to.view.layer.shadowOpacity = 0
                if self.operation == .pop && finished{
                    self.maskView.removeFromSuperview()
                    from.view.layer.transform = self.transformBackup ?? CATransform3DIdentity
                }
                if finished {
                    to.view.layer.shadowOpacity = self.shadowOpacityBackup ?? 0
                    to.view.layer.shadowOffset = self.shadowOffsetBackup ?? CGSize(width: 0, height: 0)
                    to.view.layer.shadowRadius = self.shadowRadiusBackup ?? 0
                    to.view.layer.shadowPath = self.shadowPathBackup ?? CGPath(rect: CGRect.zero, transform: nil)
                }
            }
        }
    }
}
