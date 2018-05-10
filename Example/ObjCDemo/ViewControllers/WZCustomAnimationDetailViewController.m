//
//  WZCustomAnimationDetailViewController.m
//  ObjCDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZCustomAnimationDetailViewController.h"
#import "WZCustomAnimation.h"
@implementation WZCustomAnimationDetailViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.wz_animationProcessing = [WZCustomAnimation new];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.wz_animationProcessing = [WZCustomAnimation new];
    }
    return self;
}
@end
