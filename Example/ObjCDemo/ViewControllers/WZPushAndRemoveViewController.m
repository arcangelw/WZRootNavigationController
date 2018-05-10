//
//  WZPushAndRemoveViewController.m
//  ObjCDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZPushAndRemoveViewController.h"

@interface WZPushAndRemoveViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *isAnimatedSwitch;

@end

@implementation WZPushAndRemoveViewController

- (IBAction)pushAndRemove{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WZHorizontalScrollViewController"];
    [self.wz_navigationController pushViewController:vc animated:self.isAnimatedSwitch.on completion:^(BOOL finish) {
        [self.wz_navigationController removeWithViewController:self animated:false];
    }];
}

@end
