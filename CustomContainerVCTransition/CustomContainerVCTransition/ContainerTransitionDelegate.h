//
//  ContainerTransitionDelegate.h
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//
//提供交互控制器 和 交互控制器
#import <UIKit/UIKit.h>
#import "ContainerViewControllerDelegate.h"

@class SDEPercentInteractiveTransition;

@interface ContainerTransitionDelegate : NSObject<ContainerViewControllerDelegate>

@property (nonatomic, strong) SDEPercentInteractiveTransition *interactionController;




@end
