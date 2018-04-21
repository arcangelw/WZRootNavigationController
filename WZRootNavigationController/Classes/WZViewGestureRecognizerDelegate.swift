//
//  WZContainerController.swift
//  FBSnapshotTestCase
//
//  Created by 吴哲 on 2018/4/20.
//

open class WZViewGestureRecognizerDelegate:NSObject, UIGestureRecognizerDelegate{
    public fileprivate(set) weak var containerController:UIViewController!
    public fileprivate(set) weak var contentViewController:UIViewController!
    public required init(containerController:UIViewController ,contentViewController:UIViewController) {
        self.containerController = containerController
        self.contentViewController = contentViewController
        super.init()
    }
    
}
