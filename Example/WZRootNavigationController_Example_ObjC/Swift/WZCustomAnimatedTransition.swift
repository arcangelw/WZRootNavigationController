//
//  WZCustomAnimatedTransition.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import WZRootNavigationController

@objc class WZCustomAnimatedTransition: WZAnimatedTransitionPlugin {
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from) as? WZContainerController ,
            let to = transitionContext.viewController(forKey: .to) as? WZContainerController
            else {
                fatalError("transitionContext .from/.to 必须是 WZContainerController")
        }
        
        if self.operation == .push ,from.contentViewController is WZCustomAnimatedTransitionListCollectionViewController {
            guard let fromContent = from.contentViewController as? WZCustomAnimatedTransitionListCollectionViewController ,
                let toContent = to.contentViewController as? WZCustomAnimatedTransitionDetailViewController
                else {
                    super.animateTransition(using: transitionContext)
                    return
            }
            
            guard let selected = fromContent.collectionView!.indexPathsForSelectedItems?.first,
                let cell = fromContent.collectionView!.cellForItem(at: selected) as? WZAnimatedCollectionViewCell
                else {
                    super.animateTransition(using: transitionContext)
                    return
            }
            toContent.fromSelected = selected
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
        else if self.operation == .pop ,from.contentViewController is WZCustomAnimatedTransitionDetailViewController{
            guard let fromContent = from.contentViewController as? WZCustomAnimatedTransitionDetailViewController ,
                let toContent = to.contentViewController as? WZCustomAnimatedTransitionListCollectionViewController
                else {
                    super.animateTransition(using: transitionContext)
                    return
            }
            guard let selected = fromContent.fromSelected,
                let cell = toContent.collectionView!.cellForItem(at: selected) as? WZAnimatedCollectionViewCell
                else {
                    super.animateTransition(using: transitionContext)
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
        else{
            super.animateTransition(using: transitionContext)
        }
    }
}
