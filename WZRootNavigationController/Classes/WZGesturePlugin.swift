//
//  WZContainerController.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//


/// 手势方向
@objc public enum WZGestureDirection:Int{
    case none       ///静止状态
    case top        ///向上滑动
    case left       ///向左滑动
    case bottom     ///向下划动
    case right      ///向右滑动
}

extension WZGestureDirection {
    public var isVertical:Bool {
        return self == .top || self == .bottom
    }
    public var isHorizontal:Bool {
        return self == .left || self == .right
    }
}

open class WZGesturePlugin:NSObject, UIGestureRecognizerDelegate{
    public fileprivate(set) weak var containerController:WZContainerController!
    @objc public required init(containerController:WZContainerController) {
        self.containerController = containerController
        super.init()
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = containerController.wz_navigationController , navigationController.viewControllers.count > 1 else {
            return false
        }
        if containerController.contentViewController.wz_interactivePopDisabled {
            return false
        }
        if let _ = containerController.interactiveTransition {
            return false
        }
        let beginLocation = gestureRecognizer.location(in: containerController.view)
        let allowedEdge = containerController.contentViewController.wz_interactivePopAllowedEdge
        if allowedEdge != .zero ,UIEdgeInsetsInsetRect(containerController.view.bounds, allowedEdge).contains(beginLocation) {
            return false
        }
        if let gan = gestureRecognizer as? UIPanGestureRecognizer,  gan.translation(in: gan.view).wz_direction() != .right {
            return false
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer.state == .began && gestureRecognizer.view != otherGestureRecognizer.view {
            if let scrollView = otherGestureRecognizer.view as? UIScrollView{
                
                if scrollView.panGestureRecognizer.translation(in: scrollView).wz_direction() != .right {
                    return false
                }
                if containerController.contentViewController.wz_interactivePopDisabled {
                    return false
                }
                if let _ = containerController.interactiveTransition {
                    return false
                }
                let beginLocation = gestureRecognizer.location(in: containerController.view)
                let allowedEdge = containerController.contentViewController.wz_interactivePopAllowedEdge
                if allowedEdge != .zero ,UIEdgeInsetsInsetRect(containerController.view.bounds, allowedEdge).contains(beginLocation) {
                    return false
                }
                if scrollView.wz_isSlidingToEdge {
                    scrollView.isScrollEnabled = false
                    scrollView.isScrollEnabled = true
                    return true
                }
            }
        }
        return false
    }
    
}

extension WZGesturePlugin {
    /// 手势滑动速度转化方向
    @objc public static func transformToDirection(withTranslationPoint point:CGPoint)->WZGestureDirection{
        return point.wz_direction()
    }

}
