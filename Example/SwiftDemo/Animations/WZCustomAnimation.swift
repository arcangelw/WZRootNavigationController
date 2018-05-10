//
//  WZCustomAnimation.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WZRootNavigationController

class WZCustomAnimation: NSObject,WZViewControllerAnimatedTransitioning {

    var interactiveTransition: UIPercentDrivenInteractiveTransition?
    var operation: UINavigationControllerOperation
    var transitionContext: UIViewControllerContextTransitioning?

    fileprivate var fromSelected:IndexPath?
    
    override init() {
        operation = .none
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from) as? WZContainerController ,
            let to = transitionContext.viewController(forKey: .to) as? WZContainerController
            else {
                assert(false,"transitionContext .from/.to 必须是 WZContainerController")
                return
        }
        
        if self.operation == .push {
            guard let fromContent = from.contentViewController as? WZCustomAnimationListViewController ,
                let toContent = to.contentViewController as? WZCustomAnimationDetailViewController
                else {
                    return
            }
            
            guard let selected = fromContent.collectionView!.indexPathsForSelectedItems?.first,
                let cell = fromContent.collectionView!.cellForItem(at: selected) as? WZCustomAnimatedListCell
                else {
                    return
            }
            fromSelected = selected
            transitionContext.containerView.addSubview(to.view)
            transitionContext.containerView.setNeedsLayout()
            transitionContext.containerView.layoutIfNeeded()
            to.view.alpha = 0.0
            let fromFrame = toContent.imageView.superview!.convert(cell.imageView.frame, from: cell.imageView.superview)
            let finalFrame = toContent.imageView.frame
            toContent.imageView.frame = fromFrame
            UIView.transition(with: transitionContext.containerView, duration:transitionDuration(using: transitionContext), options: [.curveEaseOut], animations: {
                to.view.alpha = 1.0
                toContent.imageView.frame = finalFrame
            }) { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            
        }
        else if self.operation == .pop {
            guard let fromContent = from.contentViewController as? WZCustomAnimationDetailViewController ,
                let toContent = to.contentViewController as? WZCustomAnimationListViewController
                else {
                    
                    return
            }
            guard let selected = fromSelected,
                let cell = toContent.collectionView!.cellForItem(at: selected) as? WZCustomAnimatedListCell
                else {
                    return
            }
            
            transitionContext.containerView.addSubview(to.view)
            transitionContext.containerView.setNeedsLayout()
            transitionContext.containerView.layoutIfNeeded()
            to.view.alpha = 0.0
            let finalFrame = fromContent.imageView.frame
            let toFrame = fromContent.imageView.superview!.convert(cell.imageView.frame, from: cell.imageView.superview)
            UIView.transition(with: transitionContext.containerView, duration:transitionDuration(using: transitionContext), options: [.curveEaseIn], animations: {
                to.view.alpha = 1.0
                fromContent.imageView.frame = toFrame
            }) { (finished) in
                if transitionContext.transitionWasCancelled {
                    fromContent.imageView.frame = finalFrame
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            
        }
    }

}
