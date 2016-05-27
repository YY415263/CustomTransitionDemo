//
//  ContainerTransitionDelegate.m
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "ContainerTransitionDelegate.h"
#import "SDEPercentInteractiveTransition.h"
#import "SlideAnimationController.h"
#import "SDEContainerViewController.h"

@implementation ContainerTransitionDelegate


- (id <UIViewControllerAnimatedTransitioning>)
containerController:(SDEContainerViewController *)containerController
fromViewController:(UIViewController*)fromVC
toViewController:(UIViewController*)toVC
{
    NSUInteger fromIndex = [containerController.viewControllers indexOfObject:fromVC];
    NSUInteger toIndex = [containerController.viewControllers indexOfObject:toVC];
    
    TabOperationDirection changeDirection = fromIndex > toIndex ? Left : Right;
    
    SlideAnimationController *sliderAnimationController = [[SlideAnimationController alloc] initWithType:changeDirection];
    return sliderAnimationController;
    
}




- (id <UIViewControllerInteractiveTransitioning>)
containerController:(SDEContainerViewController *)containerController
interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    self.interactionController = [[SDEPercentInteractiveTransition alloc] init];
    return self.interactionController;
}




@end
