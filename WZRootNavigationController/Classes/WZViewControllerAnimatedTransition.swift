//
//  WZViewControllerAnimatedTransition.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit

public enum WZViewControllerPushAnimatedType{
    case customize(Any)
    case push
    case present
}

public typealias WZViewControllerPopAnimatedOptionsInfo = [WZViewControllerPopAnimatedType]
public let WZViewControllerDefaultPopAnimatedOptionsInfo:[WZViewControllerPopAnimatedType] = [.left]
public enum WZViewControllerPopAnimatedType{
    case customize(Any)
    case left
    case right
    case top
    case bottom
}

open class WZViewControllerAnimatedTransition: NSObject {
    let operation:UINavigationControllerOperation
    weak var fromViewController:WZContainerController!
    weak var toViewController:WZContainerController!
    public required init(operation:UINavigationControllerOperation ,from fromViewController:WZContainerController, to toViewController:WZContainerController) {
        self.operation = operation
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        super.init()
    }
}

extension WZViewControllerAnimatedTransition:UIViewControllerAnimatedTransitioning{
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let from = transitionContext.viewController(forKey: .from)!
        let to = transitionContext.viewController(forKey: .to)!
        let duration = self.transitionDuration(using: transitionContext)
        let containerViewColor = transitionContext.containerView.backgroundColor
        transitionContext.containerView.backgroundColor = .black
        if self.operation == .push {
            transitionContext.containerView.addSubview(from.view)
            let frame = transitionContext.finalFrame(for: to)
            to.view.frame = frame.offsetBy(dx: frame.width, dy: 0.0)
            transitionContext.containerView.addSubview(to.view)
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut], animations: {
                from.view.alpha = 0.0
                from.view.frame = from.view.frame.offsetBy(dx: 20.0, dy: 20.0)
                to.view.frame = frame
                
            }) { (finish) in
                transitionContext.containerView.backgroundColor = containerViewColor
                from.view.alpha = 1.0
                transitionContext.completeTransition(finish)
            }
        }else if self.operation == .pop {
            
            let tabBarHidden = from.tabBarController?.tabBar.isHidden ?? true
            from.tabBarController?.tabBar.isHidden = true
            to.view.alpha = 0.5
            to.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            transitionContext.containerView.addSubview(to.view)
            transitionContext.containerView.bringSubview(toFront: from.view)
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: {
                from.view.frame = from.view.frame.offsetBy(dx: from.view.frame.width, dy: 0.0)
                to.view.alpha = 1.0
                to.view.transform = .identity
            }) { (finished) in
                transitionContext.containerView.backgroundColor = containerViewColor
                to.tabBarController?.tabBar.isHidden = tabBarHidden
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
