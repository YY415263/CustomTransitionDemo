//
//  SlideAnimationController.h
//  NavTransitionOCDemo
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface SlideAnimationController : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) UINavigationControllerOperation operationType;
- (instancetype)initWithType:(UINavigationControllerOperation)type;

@end
