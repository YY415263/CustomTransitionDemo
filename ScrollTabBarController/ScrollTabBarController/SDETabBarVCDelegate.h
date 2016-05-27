//
//  SDETabBarVCDelegate.h
//  ScrollTabBarController
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//
//自定义转场代理(提供交互控制器和动画控制器)
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SDETabBarVCDelegate : NSObject<UITabBarControllerDelegate>
@property (nonatomic, assign) BOOL interaction;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end
