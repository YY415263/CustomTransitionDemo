

//
//  ViewController.m
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/25.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UILabel *label;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.center = self.view.center;
        label.textAlignment = NSTextAlignmentCenter;
        label.bounds = CGRectMake(0, 0, 100, 40);
        [self.view addSubview:label];
    }
    label.textColor = [UIColor redColor];
    label.text = self.title;
  
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
