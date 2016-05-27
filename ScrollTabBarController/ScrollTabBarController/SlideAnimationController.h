//
//  SlideAnimationController.h
//  NavTransitionOCDemo
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum{
    Left,
    Right
}TabOperationDirection;

@interface SlideAnimationController : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) TabOperationDirection operationType;
- (instancetype)initWithType:(TabOperationDirection)type;

@end
