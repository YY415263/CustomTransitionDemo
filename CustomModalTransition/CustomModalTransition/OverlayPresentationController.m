
//
//  OverlayPresentationController.m
//  CustomModalTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "OverlayPresentationController.h"

@implementation OverlayPresentationController

- (void)presentationTransitionWillBegin
{
    self.dimmingView = [[UIView alloc] init];
    
    [self.containerView addSubview:self.dimmingView];
    
    float toViewWidth = self.containerView.frame.size.width * 2 / 3;
    float toViewHeight = self.containerView.frame.size.height * 2 / 3;
    self.dimmingView.backgroundColor = [UIColor grayColor];
    self.dimmingView.alpha = 0.5;
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
    
   
    [[self.presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.bounds = self.containerView.bounds;
    } completion:nil];

    
}

- (void)dismissalTransitionWillBegin
{
    [[self.presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
}


- (void)containerViewWillLayoutSubviews{
    
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = self.containerView.bounds;
    
    float toViewWidth = self.containerView.frame.size.width * 2 / 3;
    float toViewHeight = self.containerView.frame.size.height * 2 / 3;
    
    self.presentedView.center = self.containerView.center;
    self.presentedView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
    
    
}

@end
