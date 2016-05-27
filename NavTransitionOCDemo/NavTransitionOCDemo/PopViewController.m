//
//  PopViewController.m
//  NavTransitionOCDemo
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "PopViewController.h"
#import "SDENavigationDelegate.h"

@interface PopViewController ()
{
    UIScreenEdgePanGestureRecognizer *edgePanGesture;
}
@property (nonatomic, strong) SDENavigationDelegate *navigationDelegate;
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanGesture:)];
    edgePanGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGesture];
    
    // Do any additional setup after loading the view.
}

- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture{
 
    float translationX = [gesture translationInView:self.view].x;
    
    float screenWidth = self.view.frame.size.width * 0.3;//这里乘以0.3是为了区分系统自带的侧滑效果
    
    float translationAbs = translationX > 0 ? translationX : -translationX;
    
    float percent = translationAbs > screenWidth ? 1.0 : translationAbs / screenWidth;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.navigationDelegate = self.navigationController.delegate;
            self.navigationDelegate.interaction = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.navigationDelegate.interactionController updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
            if (percent > 0.5) {
                [self.navigationDelegate.interactionController finishInteractiveTransition];
            }else{
                [self.navigationDelegate.interactionController cancelInteractiveTransition];
            }
            self.navigationDelegate.interaction = NO;
            break;
        case UIGestureRecognizerStateCancelled:
            if (percent > 0.5) {
                [self.navigationDelegate.interactionController finishInteractiveTransition];
            }else{
                [self.navigationDelegate.interactionController cancelInteractiveTransition];
            }
            self.navigationDelegate.interaction = NO;
            break;
            
        default:
            break;
    }
    

}

- (IBAction)popMe:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)dealloc{
    [edgePanGesture removeTarget:self action:@selector(handleEdgePanGesture:)];
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
