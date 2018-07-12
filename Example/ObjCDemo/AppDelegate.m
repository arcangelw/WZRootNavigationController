//
//  AppDelegate.m
//  ObjCDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    WZTabBarController *tabBarController = [[WZTabBarController alloc] init];
//    tabBarController.tabBar.translucent = false;
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (NO) {
        tabBarController.viewControllers = @[
                                             [[WZContainerNavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"WZRootTableViewController"]],
                                             [[WZContainerNavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"WZCustomNavigationBarViewController"]],
                                             [[WZContainerNavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"WZHorizontalScrollViewController"]],
                                             [[WZContainerNavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"WZPushAndRemoveViewController"]]
                                             ];
        _window.rootViewController = [[WZRootNavigationController alloc] initWithRootViewControllerNoWrapping:tabBarController];
    }else{
        tabBarController.viewControllers = @[
                                             [[WZRootNavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"WZRootTableViewController"]],
                                             [[WZRootNavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"WZCustomNavigationBarViewController"]],
                                             [[WZRootNavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"WZHorizontalScrollViewController"]],
                                             [[WZRootNavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"WZPushAndRemoveViewController"]]
                                             ];
        _window.rootViewController = tabBarController;
    }
    
    [_window makeKeyAndVisible];
    */
    return YES;
}

@end


//@implementation UIViewController (de)
//- (void)dealloc
//{
//    NSLog(@"dealloc :\n 🈲️ %@",self.class);
//}
//@end
