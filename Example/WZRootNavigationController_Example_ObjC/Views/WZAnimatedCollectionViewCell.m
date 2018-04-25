//
//  WZAnimatedCollectionViewCell.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZAnimatedCollectionViewCell.h"

@implementation WZAnimatedCollectionViewCell

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
    _imageView = [UIImageView new];
    [self.contentView addSubview:_imageView];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
}

@end
