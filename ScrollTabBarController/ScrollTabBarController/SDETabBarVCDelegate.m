//
//  SDETabBarVCDelegate.m
//  ScrollTabBarController
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "SDETabBarVCDelegate.h"
#import "SlideAnimationController.h"

@implementation SDETabBarVCDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC  {
    NSUInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    TabOperationDirection direction = toIndex < fromIndex ? Left : Right;
    SlideAnimationController *slideAnimationController = [[SlideAnimationController alloc] initWithType:direction];
    return slideAnimationController;
    
}


- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController{
    
    self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    
    return self.interaction ? self.interactionController : nil;
}


@end
