//
//  WZNavigationBarHiddenViewController.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZNavigationBarHiddenViewController.h"

@interface WZNavigationBarHiddenViewController ()

@end

@implementation WZNavigationBarHiddenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wz_prefersNavigationBarHidden = YES;
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
