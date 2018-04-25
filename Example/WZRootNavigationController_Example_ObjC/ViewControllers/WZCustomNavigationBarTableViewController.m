//
//  WZCustomNavigationBarTableViewController.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZCustomNavigationBarTableViewController.h"
#import "WZCustomNavigationBar.h"
@interface WZCustomNavigationBarTableViewController ()

@end

@implementation WZCustomNavigationBarTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.hidesBarsOnSwipe = YES;
}

- (Class)wz_navigationBarClass{
    return WZCustomNavigationBar.class;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"cell section:%@ row:%@",@(indexPath.section) ,@(indexPath.row)];
    return cell;
}

@end
