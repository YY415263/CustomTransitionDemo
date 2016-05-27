//
//  SDENavigationDelegate.m
//  NavTransitionOCDemo
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "SDENavigationDelegate.h"
#import "SlideAnimationController.h"

@implementation SDENavigationDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    SlideAnimationController *slideAnimationController = [[SlideAnimationController alloc] initWithType:operation];
    return slideAnimationController;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    
    return self.interaction ? self.interactionController : nil;
}

@end
