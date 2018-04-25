//
//  WZPopAllowedEdgeCollectionViewController.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZPopAllowedEdgeCollectionViewController.h"
#import "WZCollectionViewCell.h"
@interface WZPopAllowedEdgeCollectionViewController ()

@end

@implementation WZPopAllowedEdgeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    ///cell 宽度 60 leftspacing 10 验证在第一列pop手势有效性
    self.wz_interactivePopAllowedEdge = UIEdgeInsetsMake(0.0f, 70.0f, 0.0f, 0.0f);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.label.text = [NSString stringWithFormat:@"item:%@",@(indexPath.item)];
    
    return cell;
}

@end
