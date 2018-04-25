//
//  WZCustomAnimatedTransitionDetailViewController.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZCustomAnimatedTransitionDetailViewController.h"
#import "WZRootNavigationController_Example_ObjC-Swift.h"
@interface WZCustomAnimatedTransitionDetailViewController ()

@end

@implementation WZCustomAnimatedTransitionDetailViewController

- (Class)wz_animatedTransitionPluginClass
{
    return WZCustomAnimatedTransition.class;
}
@end
