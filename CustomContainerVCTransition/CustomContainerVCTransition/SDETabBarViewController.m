
//
//  SDETabBarViewController.m
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//
//
#import "SDETabBarViewController.h"
#import "ContainerTransitionDelegate.h"
#import "SDEPercentInteractiveTransition.h"

@interface SDETabBarViewController ()

@end

@implementation SDETabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加滑动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handlePan:(UIPanGestureRecognizer *)gesture{
    if (self.viewControllers == nil || self.viewControllers.count < 2 || self.containerTransitionDelegate == nil) {
        return;
    }
    
    ContainerTransitionDelegate *delegate = self.containerTransitionDelegate;
    //触摸点在视图上横向移动的距离
    float translationX = [gesture translationInView:self.view].x;
    
    float screenWidth = self.view.frame.size.width;
    
    float translationAbs = translationX > 0 ? translationX : -translationX;
    
    float percent = translationAbs > screenWidth ? 1.0 : translationAbs / screenWidth;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.interactive = YES;
            //这里区分左划还是右划,左划为负数,右划为正数
            float velocityX = [gesture velocityInView:self.view].x;
            
            if (velocityX < 0) {
                if (self.mySelectedIndex < self.viewControllers.count - 1) {
                    //左划时如果当前视图不是最后一个就加一
                    self.mySelectedIndex ++;
                
                }
            }else{
                if (self.mySelectedIndex > 0) {
                    //右划时如果当前视图不是第一个就减一
                    self.mySelectedIndex --;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            //根据比例逐渐滑动
            [delegate.interactionController updateInteractiveTransitionPercentComplete:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
            self.interactive = NO;//结束后必须把交互性变为NO,因为下次切换不知道是滑动还是点击
            if (percent > 0.6) {
                [delegate.interactionController finishInteractiveTransition];
            }else{
                [delegate.interactionController cancelInteractiveTransition];
            }
            break;
        case UIGestureRecognizerStateCancelled:
            self.interactive = NO;
            if (percent > 0.6) {
                [delegate.interactionController finishInteractiveTransition];
            }else{
                [delegate.interactionController cancelInteractiveTransition];
            }
            break;
            
        default:
            break;
    }

    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



























