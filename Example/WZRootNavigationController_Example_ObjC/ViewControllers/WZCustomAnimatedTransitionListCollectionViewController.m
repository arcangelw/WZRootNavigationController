//
//  WZCustomAnimatedTransitionListCollectionViewController.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZCustomAnimatedTransitionListCollectionViewController.h"
#import "WZAnimatedCollectionViewCell.h"
#import "WZRootNavigationController_Example_ObjC-Swift.h"

@interface WZCustomAnimatedTransitionListCollectionViewController ()

@end

@implementation WZCustomAnimatedTransitionListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (Class)wz_animatedTransitionPluginClass
{
    return WZCustomAnimatedTransition.class;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat w = (self.view.frame.size.width - 10.0 * 4) / 3.0;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.itemSize = CGSizeMake(w, w);
    layout.minimumLineSpacing = 9.0f;
    layout.minimumInteritemSpacing = 9.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WZAnimatedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
