//
//  WZRootTableViewController.m
//  ObjCDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZRootTableViewController.h"

@interface WZRootTableViewController ()

@end

@implementation WZRootTableViewController



- (IBAction)ObjCToRootWithSegue:(UIStoryboardSegue *)segue
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell || indexPath.section > 0 || indexPath.row < 1) return;
     UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WZCustomAnimationListViewController"];
    switch (indexPath.row) {
        case 1:
        {
            vc.wz_animationProcessing = [WZRootTransitionAnimationProcess omniFocusWithKey:cell.contentView];
        }
            break;
        case 2:
        {
            vc.wz_animationProcessing = [WZRootTransitionAnimationProcess page];
        }
            break;
        case 3:
        {
            vc.wz_animationProcessing = [WZRootTransitionAnimationProcess fadeOut];
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:true];
    
}


@end
