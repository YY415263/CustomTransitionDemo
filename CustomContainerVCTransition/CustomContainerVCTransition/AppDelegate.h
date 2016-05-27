//
//  AppDelegate.h
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContainerTransitionDelegate;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) ContainerTransitionDelegate *containerTransitionDelegate;
@end

