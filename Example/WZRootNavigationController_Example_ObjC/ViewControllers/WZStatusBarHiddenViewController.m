//
//  WZStatusBarHiddenViewController.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZStatusBarHiddenViewController.h"

@interface WZStatusBarHiddenViewController ()

@end

@implementation WZStatusBarHiddenViewController

- (BOOL)prefersStatusBarHidden{
    return  YES;
}

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return  UIStatusBarAnimationFade;
}
@end
