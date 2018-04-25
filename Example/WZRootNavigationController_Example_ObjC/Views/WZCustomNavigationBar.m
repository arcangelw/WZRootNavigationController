//
//  WZCustomNavigationBar.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZCustomNavigationBar.h"

@implementation WZCustomNavigationBar

/// iOS11失效了 
- (CGSize)sizeThatFits:(CGSize)size
{
    size = [super sizeThatFits:size];
    size.height += 50.f;
    return  size;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    path.lineWidth = 2.0;
    [[UIColor greenColor] setFill];
    [[UIColor grayColor] setStroke];
    [path fill];
    [path stroke];
}

@end
