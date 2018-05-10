//
//  WZDisableInteractivePop&StatusHiddenViewController.m
//  ObjCDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZDisableInteractivePop&StatusHiddenViewController.h"

@interface WZDisableInteractivePop_StatusHiddenViewController ()

@end

@implementation WZDisableInteractivePop_StatusHiddenViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // disable interactive pop
    // set wz_popEdge = UIRectEdgeNone
    self.wz_popEdge = UIRectEdgeNone;
}
- (IBAction)popSwitch:(UIBarButtonItem *)sender {
    if (self.wz_popEdge == UIRectEdgeNone) {
        self.wz_popEdge = UIRectEdgeLeft;
        self.navigationItem.title = @"pop on";
        sender.title = @"off";
    }else{
        self.wz_popEdge = UIRectEdgeNone;
        self.navigationItem.title = @"pop off";
        sender.title = @"on";
    }
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationFade;
}

@end
