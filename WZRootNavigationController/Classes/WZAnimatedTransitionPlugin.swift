//
//  WZAnimatedTransitionPlugin.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit

open class WZAnimatedTransitionPlugin: NSObject {
    let operation:UINavigationControllerOperation
    weak var fromViewController:WZContainerController!
    weak var toViewController:WZContainerController!
    @objc public required init(operation:UINavigationControllerOperation ,from fromViewController:WZContainerController, to toViewController:WZContainerController) {
        self.operation = operation
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        super.init()
    }
}

extension WZAnimatedTransitionPlugin:UIViewControllerAnimatedTransitioning{
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from) as? WZContainerController,
            let to = transitionContext.viewController(forKey: .to) as? WZContainerController
            else {
                fatalError("transitionContext .from/.to 必须是 WZContainerController")
                return
        }
        
        let duration = self.transitionDuration(using: transitionContext)
        let containerViewColor = transitionContext.containerView.backgroundColor
        if self.operation == .push {
            transitionContext.containerView.backgroundColor = from.contentViewController.view.backgroundColor
            transitionContext.containerView.addSubview(from.view)
            let hudView = UIView(frame:transitionContext.containerView.bounds)
            hudView.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.4)
            hudView.alpha = 0.1
            transitionContext.containerView.addSubview(hudView)
            let frame = transitionContext.finalFrame(for: to)
            to.view.frame = frame.offsetBy(dx: frame.width, dy: 0.0)
            transitionContext.containerView.addSubview(to.view)
            UIView.animate(withDuration: duration, delay: 0.0, options:[.curveEaseOut], animations: {
                from.view.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
                hudView.alpha = 1.0
                to.view.frame = frame
                
            }) { (finish) in
                hudView.removeFromSuperview()
                transitionContext.containerView.backgroundColor = containerViewColor
                from.view.alpha = 1.0
                from.view.transform = .identity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }else if self.operation == .pop {
            transitionContext.containerView.backgroundColor = to.contentViewController.view.backgroundColor
            let tabBarHidden = from.tabBarController?.tabBar.isHidden ?? true
            from.tabBarController?.tabBar.isHidden = true
            to.view.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            transitionContext.containerView.addSubview(to.view)
            let hudView = UIView(frame:transitionContext.containerView.bounds)
            hudView.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.4)
            hudView.alpha = 1.0
            transitionContext.containerView.addSubview(hudView)
            transitionContext.containerView.bringSubview(toFront: from.view)
            UIView.animate(withDuration: duration, delay: 0.0, options:[.curveLinear], animations: {
                to.view.transform = .identity
                hudView.alpha = 0.0
                from.view.frame = from.view.frame.offsetBy(dx: from.view.frame.width, dy: 0.0)
            }) { (finished) in
                hudView.removeFromSuperview()
                transitionContext.containerView.backgroundColor = containerViewColor
                to.tabBarController?.tabBar.isHidden = tabBarHidden
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
