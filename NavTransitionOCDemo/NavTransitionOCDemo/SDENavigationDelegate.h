//
//  SDENavigationDelegate.h
//  NavTransitionOCDemo
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SDENavigationDelegate : NSObject<UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL interaction;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end
