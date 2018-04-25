//
//  WZCustomAnimatedTransitionDetailViewController.h
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZCustomAnimatedTransitionDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/// selected
@property(nonatomic ,strong) NSIndexPath *fromSelected;
@end
