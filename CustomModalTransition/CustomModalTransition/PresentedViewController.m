//
//  PresentedViewController.m
//  CustomModalTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "PresentedViewController.h"
#import "SEDModalTransitionDelegate.h"

@interface PresentedViewController ()
@property (strong, nonatomic) IBOutlet UIButton *dismissBtn;


@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    CGAffineTransform btnTransform = CGAffineTransformMakeScale(0.1, 0.1);
    btnTransform = CGAffineTransformRotate(btnTransform, 3 * M_PI);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dismissBtn.transform = btnTransform;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
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
