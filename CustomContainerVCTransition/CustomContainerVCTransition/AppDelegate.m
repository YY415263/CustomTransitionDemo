//
//  AppDelegate.m
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "AppDelegate.h"
#import "SDETabBarViewController.h"
#import "ViewController.h"
#import "ContainerTransitionDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    ViewController *subVC0 = [[ViewController alloc] init];
    subVC0.view.tag = 0;
    subVC0.view.backgroundColor = [UIColor colorWithRed:0.839 green:1.000 blue:0.586 alpha:1.000];
    subVC0.title = @"iPhone";
    
    ViewController *subVC1 = [[ViewController alloc] init];
    subVC1.view.tag = 1;
    subVC1.view.backgroundColor = [UIColor colorWithRed:0.144 green:0.994 blue:1.000 alpha:1.000];
    subVC1.title = @"Vertu";
    
    ViewController *subVC2 = [[ViewController alloc] init];
    subVC2.view.tag = 2;
    subVC2.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.491 blue:0.913 alpha:1.000];
    subVC2.title = @"Samsung";
    
    ViewController *subVC3 = [[ViewController alloc] init];
    subVC0.view.tag = 3;
    subVC3.view.backgroundColor = [UIColor colorWithRed:0.395 green:0.363 blue:1.000 alpha:1.000];
    subVC3.title = @"HTC";
    
    
    ViewController *subVC4 = [[ViewController alloc] init];
    subVC4.view.tag = 3;
    subVC4.view.backgroundColor = [UIColor colorWithRed:0.517 green:1.000 blue:0.710 alpha:1.000];
    subVC4.title = @"Huawei";

    
    NSArray *viewControllers = @[subVC0,subVC1,subVC2,subVC3,subVC4];
    
    SDETabBarViewController *tabBarViewController = [[SDETabBarViewController alloc] initWithViewControllers:viewControllers];
    tabBarViewController.view.backgroundColor = [UIColor whiteColor];
    
    
    self.containerTransitionDelegate = [[ContainerTransitionDelegate alloc] init];
    //如果代理不为空,则转场可以分为交互和非交互
    //如果代理为空,则只能点击转场,也没有滑动效果
    tabBarViewController.containerTransitionDelegate = self.containerTransitionDelegate;
    
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];
    
       
    
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
