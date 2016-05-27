//
//  SDEPercentDrivenInteractiveTransition.h
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ContainerTransitionContext.h"
@interface SDEPercentInteractiveTransition : NSObject<UIViewControllerInteractiveTransitioning>

@property (nonatomic, weak) ContainerTransitionContext *containerTransitionContext;


- (void)updateInteractiveTransitionPercentComplete:(CGFloat)percent;

- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

@end
