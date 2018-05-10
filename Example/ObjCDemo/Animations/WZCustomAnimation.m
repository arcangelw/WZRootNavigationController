//
//  WZCustomAnimation.m
//  ObjCDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZCustomAnimation.h"
#import "WZCustomAnimationDetailViewController.h"
#import "WZCustomAnimationListViewController.h"

@interface WZCustomAnimation()
/// fromSelected
@property(nonatomic ,strong) NSIndexPath *fromSelected;
@end
@implementation WZCustomAnimation
@synthesize transitionContext = _transitionContext;
@synthesize operation = _operation;
@synthesize interactiveTransition = _interactiveTransition;


- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    WZContainerController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    WZContainerController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (self.operation == UINavigationControllerOperationPush) {
        WZCustomAnimationListViewController *fromContent = (WZCustomAnimationListViewController*)from.contentViewController;
        WZCustomAnimationDetailViewController *toContent = (WZCustomAnimationDetailViewController*)to.contentViewController;
        
        NSIndexPath *selected = fromContent.collectionView.indexPathsForSelectedItems.firstObject;
        if (!selected) return;
        WZCustomAnimatedListCell * cell = (WZCustomAnimatedListCell*)[fromContent.collectionView cellForItemAtIndexPath:selected];
        if (!cell) return;
        self.fromSelected = selected;
        [transitionContext.containerView addSubview:to.view];
        [transitionContext.containerView setNeedsLayout];
        [transitionContext.containerView  layoutIfNeeded];
        to.view.alpha = 0.0f;
        CGRect fromFrame = [toContent.imageView.superview convertRect:cell.imageView.frame fromView:cell.imageView.superview];
        CGRect finalFrame = toContent.imageView.frame;
        toContent.imageView.frame = fromFrame;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            to.view.alpha = 1.0;
            toContent.imageView.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition: !transitionContext.transitionWasCancelled];
        }];
        
    }else if (self.operation == UINavigationControllerOperationPop){
        
        WZCustomAnimationDetailViewController *fromContent = (WZCustomAnimationDetailViewController*)from.contentViewController;
        WZCustomAnimationListViewController *toContent = (WZCustomAnimationListViewController*)to.contentViewController;
        WZCustomAnimatedListCell * cell = (WZCustomAnimatedListCell*)[toContent.collectionView cellForItemAtIndexPath:self.fromSelected];
        if (!cell) return;
        [transitionContext.containerView addSubview:to.view];
        [transitionContext.containerView setNeedsLayout];
        [transitionContext.containerView  layoutIfNeeded];
        CGRect finalFrame = fromContent.imageView.frame;
        CGRect toFrame = [fromContent.imageView.superview convertRect:cell.imageView.frame fromView:cell.imageView.superview];
        to.view.alpha = 0.0;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            to.view.alpha = 1.0;
            fromContent.imageView.frame = toFrame;
        } completion:^(BOOL finished) {
            if (transitionContext.transitionWasCancelled) {
                fromContent.imageView.frame = finalFrame;
            }
            [transitionContext completeTransition: !transitionContext.transitionWasCancelled];
        }];
        
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (id<WZViewControllerAnimatedTransitioning> _Nonnull)convertTransitionAnimation {
    return self;
}

@end
