//
//  WZPushAndRemoveViewController.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZPushAndRemoveViewController.h"

@interface WZPushAndRemoveViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *isAnimatingSwitch;

@end

@implementation WZPushAndRemoveViewController

- (void)dealloc
{
    NSLog(@"push and remove dealloc");
}

- (IBAction)pushAndRemove:(id)sender {
    UIViewController *normal = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WZNormalViewController"];
    [self.wz_navigationController pushViewController:normal animated:self.isAnimatingSwitch.isOn completion:^(BOOL finished) {
        [self.wz_navigationController removeWithViewController:self animated:NO];
    }];
}


@end
