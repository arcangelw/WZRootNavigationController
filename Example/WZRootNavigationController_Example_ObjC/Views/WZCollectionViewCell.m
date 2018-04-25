//
//  WZCollectionViewCell.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZCollectionViewCell.h"

@implementation WZCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
         [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    _label = [UILabel new];
    [self.contentView addSubview:_label];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_label]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_label)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_label]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_label)]];
}

@end
