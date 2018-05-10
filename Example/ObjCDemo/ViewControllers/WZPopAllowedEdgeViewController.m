//
//  WZPopAllowedEdgeViewController.m
//  ObjCDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZPopAllowedEdgeViewController.h"

@interface WZPopAllowedEdgeViewController ()

@end

@implementation WZPopAllowedEdgeViewController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad{
    [super viewDidLoad];
    // left 设置一个cell宽度 + 边距
    CGFloat w = (self.view.frame.size.width - 10.0 * 6) / 5.0;
    self.wz_popAllowedEdge = UIEdgeInsetsMake(0.0, w, 0.0, 0.0);
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    CGFloat w = (self.view.frame.size.width - 10.0 * 6) / 5.0;
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
    WZCustomAnimatedListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.backgroundColor = WZRandomColor;
    return cell;
}
@end
