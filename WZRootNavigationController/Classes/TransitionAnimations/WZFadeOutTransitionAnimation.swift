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
        guard let from = transitionContext.viewController(forKey: .from) as? WZContainerController,
            let to = transitionContext.viewController(forKey: .to) as? WZContainerController
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
        containerView.addSubview(from.view)
        containerView.addSubview(to.view)
        to.view.layer.opacity = 0.0
        UIView.animate(withDuration:duration, delay: 0, options: .curveEaseInOut, animations: {
            to.view.layer.opacity = 1.0
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
