//
//  WZAnimatedTransitionPlugin.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/20.
//

import UIKit

open class WZAnimatedTransitionPlugin: NSObject {
    @objc public let operation:UINavigationControllerOperation
    @objc public fileprivate(set) weak var fromViewController:WZContainerController!
    @objc public fileprivate(set) weak var toViewController:WZContainerController!
    fileprivate lazy var maskView: UIView = {
        let maskView = UIView(frame: UIScreen.main.bounds)
        maskView.backgroundColor = UIColor.black
        return maskView
    }()
    @objc public required init(operation:UINavigationControllerOperation ,from fromViewController:WZContainerController, to toViewController:WZContainerController) {
        self.operation = operation
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        super.init()
    }
}

extension WZAnimatedTransitionPlugin:UIViewControllerAnimatedTransitioning{
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard var from = transitionContext.viewController(forKey: .from) as? WZContainerController,
            var to = transitionContext.viewController(forKey: .to) as? WZContainerController
            else {
                fatalError("transitionContext .from/.to 必须是 WZContainerController")
                return
        }
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        
        var fromStartPx:CGFloat = 0.0
        var fromEndPx:CGFloat = -UIScreen.main.bounds.width * 0.618 //视差设置
        var toStartPx:CGFloat = UIScreen.main.bounds.width
        var toEndPx:CGFloat = 0.0
        var startOpacity:Float = 0.0
        var endOpacity:Float = 0.3
        
        if self.operation == .pop {
            swap(&from, &to)
            swap(&fromStartPx, &fromEndPx)
            swap(&toStartPx, &toEndPx)
            swap(&startOpacity, &endOpacity)
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
        to.view.layer.shadowOpacity = 0.5
        to.view.layer.shadowOffset = CGSize(width: -3.0, height: 0.0)
        to.view.layer.shadowRadius = 5.0
        to.view.layer.shadowPath = CGPath(rect: to.view.layer.bounds, transform: nil)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.maskView.layer.opacity = endOpacity
            from.view.layer.position.x = fromEndPx + from.view.layer.bounds.width / 2.0
            to.view.layer.position.x = toEndPx + to.view.layer.bounds.width / 2.0
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.maskView.removeFromSuperview()
            if !transitionContext.transitionWasCancelled {
                to.view.layer.shadowOpacity = 0.0
                if finished {
                    to.view.layer.shadowOpacity = shadowOpacityBackup
                    to.view.layer.shadowOffset = shadowOffsetBackup
                    to.view.layer.shadowRadius = shadowRadiusBackup
                    to.view.layer.shadowPath = shadowPathBackup
                }
            }
        }
    }
}
