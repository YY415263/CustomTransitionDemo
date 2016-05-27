//
//  SlideAnimationController.m
//  NavTransitionOCDemo
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "SlideAnimationController.h"

@implementation SlideAnimationController

- (instancetype)initWithType:(TabOperationDirection)type{
    if (self == [super init]) {
        self.operationType = type;
    }
    return self;
}

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

    CGFloat translation = containerView.frame.size.width;
    
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    switch (self.operationType) {
        case Left:
            break;
        case Right:
            translation = -translation;
            break;
        default:
            break;
    }
    
    toViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
    fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);

    
    [containerView addSubview:toView];
    
    toView.transform = toViewTransform;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
        
    }];
   
    
}














@end
