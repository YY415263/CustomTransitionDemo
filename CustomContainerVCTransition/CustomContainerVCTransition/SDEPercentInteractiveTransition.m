
//
//  SDEPercentDrivenInteractiveTransition.m
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//
//负责交互
#import "SDEPercentInteractiveTransition.h"
#import "ContainerTransitionContext.h"

@implementation SDEPercentInteractiveTransition

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if ([transitionContext isKindOfClass:[ContainerTransitionContext class]]) {
        self.containerTransitionContext = transitionContext;
        [self.containerTransitionContext activateInteractiveTransition];
    }
}

- (void)updateInteractiveTransitionPercentComplete:(CGFloat)percent{
    [self.containerTransitionContext updateInteractiveTransition:percent];
}

- (void)cancelInteractiveTransition{
    [self.containerTransitionContext cancelInteractiveTransition];
}
- (void)finishInteractiveTransition{
    [self.containerTransitionContext finishInteractiveTransition];
}

@end
