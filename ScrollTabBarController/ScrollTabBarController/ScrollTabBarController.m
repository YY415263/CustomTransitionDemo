//
//  ScrollTabBarController.m
//  ScrollTabBarController
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "ScrollTabBarController.h"
#import "SDETabBarVCDelegate.h"

@interface ScrollTabBarController ()
{
    UIPanGestureRecognizer *panGesture;
    NSInteger subViewControllerCount;
}
@property (nonatomic, strong) SDETabBarVCDelegate *tabBarVCDelegate;
@end

@implementation ScrollTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarVCDelegate = [[SDETabBarVCDelegate alloc] init];
    self.delegate = self.tabBarVCDelegate;
    
    
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGesture];
    
    subViewControllerCount = self.viewControllers != nil ? self.viewControllers.count : 0;
    
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    float translationX = [gesture translationInView:self.view].x;
    
    float screenWidth = self.view.frame.size.width;
    float translationAbs = translationX > 0 ? translationX : -translationX;
    
    float percent = translationAbs > screenWidth ? 1.0 : translationAbs / screenWidth;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.tabBarVCDelegate.interaction = YES;
            float velocityX = [panGesture velocityInView:self.view].x;
            if (velocityX < 0) {
                if (self.selectedIndex < subViewControllerCount - 1) {
                    self.selectedIndex += 1;
                }
            }else{
                if (self.selectedIndex > 0) {
                     self.selectedIndex -= 1;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.tabBarVCDelegate.interactionController updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
            if (percent > 0.3) {
                self.tabBarVCDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarVCDelegate.interactionController finishInteractiveTransition];
                
            }else{
                self.tabBarVCDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarVCDelegate.interactionController cancelInteractiveTransition];
            }
            self.tabBarVCDelegate.interaction = NO;//必须要写的
            break;
        case UIGestureRecognizerStateCancelled:
            if (percent > 0.3) {
                self.tabBarVCDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarVCDelegate.interactionController finishInteractiveTransition];
                
            }else{
                self.tabBarVCDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarVCDelegate.interactionController cancelInteractiveTransition];
            }
            self.tabBarVCDelegate.interaction = NO;//必须要写的
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
