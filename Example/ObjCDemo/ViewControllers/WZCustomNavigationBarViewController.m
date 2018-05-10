//
//  WZCustomNavigationBarViewController.m
//  ObjCDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZCustomNavigationBarViewController.h"

@interface WZCustomNavigationBarViewController ()

@end

@implementation WZCustomNavigationBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.hidesBarsOnSwipe = YES;
}

- (Class)wz_navigationBarClass
{
    return WZCustomNavigationBar.class;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.contentView.backgroundColor = WZRandomColor;
    return cell;
}

@end
