
//
//  OverlayAnimationController.m
//  CustomModalTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "OverlayAnimationController.h"

@implementation OverlayAnimationController
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    float duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented) {
        
        
        float toViewWidth = containerView.frame.size.width * 2 / 3;
        float toViewHeight = containerView.frame.size.height * 2 / 3;
        toView.center = containerView.center;
        toView.bounds = CGRectMake(0, 0, 1, toViewHeight);
        [containerView addSubview:toView];
        
        
        UIView *dimmingView = [[UIView alloc] init];
        [containerView insertSubview:dimmingView belowSubview:toView];
        dimmingView.backgroundColor = [UIColor grayColor];
        dimmingView.alpha = 0.5;
        dimmingView.center = containerView.center;
        dimmingView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
        
        
        [UIView animateWithDuration:duration animations:^{
            toView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
            dimmingView.bounds = containerView.bounds;
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
        
        
    }
    
    if (fromVC.isBeingDismissed) {
        float fromViewHeight = fromView.frame.size.height;
        [UIView animateWithDuration:duration animations:^{
            fromView.bounds = CGRectMake(0, 0, 1, fromViewHeight);
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
        
        
        
        
    }
    
    
}



@end
