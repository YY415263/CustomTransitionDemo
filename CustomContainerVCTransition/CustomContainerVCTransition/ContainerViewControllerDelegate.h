//
//  ContainerViewControllerDelegate.h
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/25.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SDEContainerViewController;
@protocol ContainerViewControllerDelegate <NSObject>
- (id <UIViewControllerAnimatedTransitioning>)
containerController:(SDEContainerViewController *)containerController
fromViewController:(UIViewController*)fromVC
toViewController:(UIViewController*)toVC;

@optional

- (id <UIViewControllerInteractiveTransitioning>)
containerController:(SDEContainerViewController *)containerController
interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController;

@end
