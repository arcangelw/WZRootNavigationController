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
    init(operation:UINavigationControllerOperation ,from fromViewController:WZContainerController, to toViewController:WZContainerController) {
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
        
    }
}
