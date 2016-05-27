

//
//  PresentingViewController.m
//  CustomModalTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "PresentingViewController.h"
#import "SEDModalTransitionDelegate.h"
#import "PresentedViewController.h"

@interface PresentingViewController ()
@property (nonatomic, strong)SEDModalTransitionDelegate *presentTransitionDelegate;
@end

@implementation PresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.presentTransitionDelegate = [[SEDModalTransitionDelegate alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    PresentedViewController *presentedVC = segue.destinationViewController;
    presentedVC.transitioningDelegate = self.presentTransitionDelegate;
    presentedVC.modalPresentationStyle = UIModalPresentationCustom;
    [super prepareForSegue:segue sender:sender];

}


@end
