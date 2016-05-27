//
//  SEDViewContainerViewController.h
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//
//tabBarController真实实现




#import <UIKit/UIKit.h>
@class ContainerTransitionDelegate;

@interface SDEContainerViewController : UIViewController

//相当于TabBar的作用
@property (nonatomic, strong) UIView *buttonTabBar;
//自控制器
@property (nonatomic, strong) NSArray *viewControllers;
//控制是否是交互切换(区别 点击切换/滑动切换)
@property (nonatomic, assign) BOOL interactive;
//转场代理(负责提供动画控制器和交互控制器)
@property (nonatomic, weak) ContainerTransitionDelegate *containerTransitionDelegate;
//是否恢复(当滑动切换的时,如果中途取消切换会用到)
@property (nonatomic, assign) BOOL shouldReserve;
//上一个(当滑动切换的时,如果中途取消切换会用到)
@property (nonatomic, assign) NSInteger priorSelectedIndex;
//当前选中的index
@property (nonatomic, assign) NSInteger mySelectedIndex;
//当前选中的控制器
@property (nonatomic, strong) UIViewController *selectedViewController;
//初始方法
-(instancetype)initWithViewControllers:(NSArray *)viewControllers;
//此方法用来逐渐改变按钮的颜色
- (void)graduallyChangeTabButtonAppearWithFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex percent:(float)percent;
//恢复上一个,滑动转场取消时
- (void)restoreSelectedIndex;

@end
