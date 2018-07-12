//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WZRootNavigationController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /**
        let window = UIWindow(frame: UIScreen.main.bounds)
        let story = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = WZTabBarController()
        tabBarController.tabBar.isTranslucent = false
        if false {
            tabBarController.viewControllers = [
            WZContainerNavigationController(rootViewController: story.instantiateViewController(withIdentifier: "WZRootTableViewController")),
            WZContainerNavigationController(rootViewController: story.instantiateViewController(withIdentifier: "WZCustomNavigationBarViewController")),
            WZContainerNavigationController(rootViewController: story.instantiateViewController(withIdentifier: "WZHorizontalScrollViewController")),
            WZContainerNavigationController(rootViewController: story.instantiateViewController(withIdentifier: "WZPushAndRemoveViewController"))
            ]
            window.rootViewController = WZRootNavigationController(rootViewControllerNoWrapping: tabBarController)
        }else{
            tabBarController.viewControllers = [
                WZRootNavigationController(rootViewController: story.instantiateViewController(withIdentifier: "WZRootTableViewController")),
                WZRootNavigationController(rootViewController: story.instantiateViewController(withIdentifier: "WZCustomNavigationBarViewController")),
                WZRootNavigationController(rootViewController: story.instantiateViewController(withIdentifier: "WZHorizontalScrollViewController")),
                WZRootNavigationController(rootViewController: story.instantiateViewController(withIdentifier: "WZPushAndRemoveViewController"))
            ]
            window.rootViewController = tabBarController
        }
        window.makeKeyAndVisible()
        self.window = window
        */
        return true
    }

}


extension UIColor {
    
    static var randomColor:UIColor {
        return UIColor(red:CGFloat(arc4random_uniform(255))/CGFloat(255.0), green:CGFloat(arc4random_uniform(255))/CGFloat(255.0), blue:CGFloat(arc4random_uniform(255))/CGFloat(255.0) , alpha: 1)
    }
}
