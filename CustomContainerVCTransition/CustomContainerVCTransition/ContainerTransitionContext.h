//
//  ContainerTransitionContext.h
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//
//提供转场数据源
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SDEContainerViewController;
@class ContainerTransitionDelegate;
@interface ContainerTransitionContext : NSObject<UIViewControllerContextTransitioning>
//初始化
- (instancetype)initWithContainerViewController:
        (SDEContainerViewController *)containerViewController
                                  containerView:(UIView *)containerView
                             fromViewController:(UIViewController *)fromVC
                               toViewController:(UIViewController *)toVC;
//开始交互转场
- (void)startInteractiveTranstionWithDelegate:(ContainerTransitionDelegate *)delegate;
//开始非交互转场
- (void)startNonInteractiveTransitionWithDelegate:(ContainerTransitionDelegate *)delegate;
//更新交互转场进度
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
//取消转场(交互转场用到)
- (void)cancelInteractiveTransition;
//完成转场
- (void)finishInteractiveTransition;
//交互转场
- (void)activateInteractiveTransition;
//非交互转场(点击)
- (void)activateNonInteractiveTransition;

@end
