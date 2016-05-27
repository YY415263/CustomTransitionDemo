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
    Presentation,
    Dismissal
}ModalOperation;

@interface SlideAnimationController : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) ModalOperation operationType;
- (instancetype)initWithType:(ModalOperation)type;

@end
