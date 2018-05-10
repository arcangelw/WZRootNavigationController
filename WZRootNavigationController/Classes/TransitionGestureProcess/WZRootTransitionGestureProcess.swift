//
//  WZRootTransitionGestureProcess.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/5/10.
//  Copyright © 2018年 arcangelw All rights reserved.
//

import UIKit

extension UIRectEdge{
    public var isOnly:Bool {
        if self == .all {
            return false
        }
        let all:[UIRectEdge] = [.top,.left,.bottom,.right].filter({self.contains($0)})
        return all.count <= 1
    }
}

open class WZRootTransitionGestureProcess:NSObject,WZGestureRecognizerDelegate{
    
    open var popGestureRecognizer: UIPanGestureRecognizer
    
    open weak var container: WZContainerController!{
        willSet{
            if container != .none {
               container.view.removeGestureRecognizer(popGestureRecognizer)
            }
            newValue.view.addGestureRecognizer(popGestureRecognizer)
        }
    }
    
    open var currentInteractiveEdge: UIRectEdge = []

    public override init() {
        popGestureRecognizer = UIPanGestureRecognizer()
        popGestureRecognizer.maximumNumberOfTouches = 1
        popGestureRecognizer.delaysTouchesBegan = true
        super.init()
        popGestureRecognizer.delegate = self
        popGestureRecognizer.addTarget(self, action: #selector(self.handlePopRecognizer(_:)))
    }
    
    #if WZDEBUG
    deinit {
        print(self.classForCoder, #line , #function)
    }
    #endif
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIControl {
            return false
        }
        return true
    }
    
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if container.wz_popEdge == [] {
            return false
        }
        
        guard let navigationController = container.wz_navigationController , navigationController.viewControllers.count > 1 else {
            return false
        }
        
        if container.wz_animationProcessing.convertTransitionAnimation().interactiveTransition != nil {
            return false
        }
        
        let allowedEdge = container.wz_popAllowedEdge
        if allowedEdge != .zero {
            let beginLocation = gestureRecognizer.location(in: container.view)
            if UIEdgeInsetsInsetRect(container.view.bounds, allowedEdge).contains(beginLocation) {
                 return false
            }
        }
        
        if let gan = gestureRecognizer as? UIPanGestureRecognizer,!container.wz_popEdge.contains(gan.wz_direction) {
            return false
        }
        return true
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer.state == .began && gestureRecognizer.view != otherGestureRecognizer.view {
            if let scrollView = otherGestureRecognizer.view as? UIScrollView{
                
                if container.wz_popEdge == [] {
                    return false
                }
                
                if container.wz_animationProcessing.convertTransitionAnimation().interactiveTransition != nil {
                    return false
                }
                
                let allowedEdge = container.wz_popAllowedEdge
                if allowedEdge != .zero {
                    let beginLocation = gestureRecognizer.location(in: container.view)
                    if UIEdgeInsetsInsetRect(container.view.bounds, allowedEdge).contains(beginLocation) {
                        return false
                    }
                }
                
                let scrollDirection = scrollView.panGestureRecognizer.wz_direction(in: scrollView)
                
                if !container.wz_popEdge.contains(scrollDirection) {
                    return false
                }
                
                var isSlidingToEdge = false
                assert(container.wz_popEdge.isOnly || (!container.wz_popEdge.isOnly && allowedEdge == .zero), "多方位Pop和限定响应区域设置请自定义手势处理，此处只提供其他条件下基本返回功能")
                if container.wz_popEdge.contains(scrollDirection){
                    if .top == scrollDirection {
                        isSlidingToEdge = scrollView.wz_isSlidingToEdgeTop
                    }
                    else if .left == scrollDirection {
                        isSlidingToEdge = scrollView.wz_isSlidingToEdgeLeft
                    }
                    else if .bottom == scrollDirection {
                        isSlidingToEdge = scrollView.wz_isSlidingToEdgeBottom
                    }
                    else if  .right == scrollDirection {
                        isSlidingToEdge = scrollView.wz_isSlidingToEdgeRight
                    }
                }
                if isSlidingToEdge {
                    /// 处理滑动pop时候scrollView的bounces效果
                    scrollView.isScrollEnabled = false
                    scrollView.isScrollEnabled = true
                    return true
                }
            }
        }
        return false
    }
 
    open func handlePopRecognizer(_ recognizer:UIPanGestureRecognizer){
        
        let animation = container.wz_animationProcessing.convertTransitionAnimation()
        var progress:CGFloat =  0.0
        switch currentInteractiveEdge {
        case .left,.right:
            progress = recognizer.translation(in: container.view).x / container.view.frame.width
            break
        case .top,.bottom:
            progress = recognizer.translation(in: container.view).y / container.view.frame.height
            break
        default:
            if let interactiveTransition = animation.interactiveTransition {
                interactiveTransition.cancel()
                animation.interactiveTransition = nil
                return
            }
            break
        }
        progress = min(1.0, max(0.0, abs(progress)))
        if .began == recognizer.state {
            if animation.interactiveTransition != nil { return }
            currentInteractiveEdge = recognizer.wz_direction(in: container.view)
            animation.interactiveTransition = UIPercentDrivenInteractiveTransition()
            container.navigationController?.popViewController(animated: true)
        }
        else if .changed == recognizer.state , let interactiveTransition = animation.interactiveTransition {
            interactiveTransition.update(progress)
        }
        else if (( .ended == recognizer.state ) || (.cancelled == recognizer.state)), let interactiveTransition = animation.interactiveTransition {
            
            if progress > 0.3 {
                interactiveTransition.finish()
            }else{
                interactiveTransition.cancel()
            }
            currentInteractiveEdge = []
            animation.interactiveTransition = nil
        }else{
            currentInteractiveEdge = []
            animation.interactiveTransition = nil
        }
    }

}



open class WZRootTransitionScreenEdgeGestureProcess:NSObject,WZGestureRecognizerDelegate{
    
    open var popGestureRecognizer: UIPanGestureRecognizer
    
    open weak var container: WZContainerController!{
        willSet{
            if container != .none {
                container.view.removeGestureRecognizer(popGestureRecognizer)
            }
            (popGestureRecognizer as! UIScreenEdgePanGestureRecognizer).edges = newValue.wz_popEdge
            newValue.view.addGestureRecognizer(popGestureRecognizer)
        }
    }
    
    open var currentInteractiveEdge: UIRectEdge = []

    public override init() {
        popGestureRecognizer = UIScreenEdgePanGestureRecognizer()
        super.init()
        popGestureRecognizer.addTarget(self, action: #selector(self.handlePopRecognizer(_:)))
    }
    
    #if WZDEBUG
    deinit {
        print(self.classForCoder, #line , #function)
    }
    #endif

    open func handlePopRecognizer(_ recognizer: UIPanGestureRecognizer) {
        let animation = container.wz_animationProcessing.convertTransitionAnimation()
        var progress:CGFloat =  0.0
        switch currentInteractiveEdge {
        case .left,.right:
            progress = recognizer.translation(in: container.view).x / container.view.frame.width
            break
        case .top,.bottom:
            progress = recognizer.translation(in: container.view).y / container.view.frame.height
            break
        default:
            if let interactiveTransition = animation.interactiveTransition {
                interactiveTransition.cancel()
                animation.interactiveTransition = nil
                return
            }
            break
        }
        progress = min(1.0, max(0.0, abs(progress)))
        if .began == recognizer.state {
            if animation.interactiveTransition != nil { return }
            currentInteractiveEdge = recognizer.wz_direction(in: container.view)
            animation.interactiveTransition = UIPercentDrivenInteractiveTransition()
            container.navigationController?.popViewController(animated: true)
        }
        else if .changed == recognizer.state , let interactiveTransition = animation.interactiveTransition {
            interactiveTransition.update(progress)
        }
        else if (( .ended == recognizer.state ) || (.cancelled == recognizer.state)), let interactiveTransition = animation.interactiveTransition {
            
            if progress > 0.3 {
                interactiveTransition.finish()
            }else{
                interactiveTransition.cancel()
            }
            currentInteractiveEdge = []
            animation.interactiveTransition = nil
        }else{
            currentInteractiveEdge = []
            animation.interactiveTransition = nil
        }
    }
}
