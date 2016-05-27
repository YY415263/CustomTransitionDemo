//
//  SEDModalTransitionDelegate.m
//  CustomModalTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "SEDModalTransitionDelegate.h"
#import "SlideAnimationController.h"
#import "OverlayAnimationController.h"
#import "OverlayPresentationController.h"

@implementation SEDModalTransitionDelegate
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
////    ModalOperation operation = Presentation;
////    SlideAnimationController *slideAnimationController = [[SlideAnimationController alloc] initWithType:operation];
////    return slideAnimationController;
//    
//    OverlayAnimationController *overlayAnimationController = [[OverlayAnimationController alloc] init];
//    return overlayAnimationController;
//}
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
////    ModalOperation operation = Dismissal;
////    SlideAnimationController *slideAnimationController = [[SlideAnimationController alloc] initWithType:operation];
////    return slideAnimationController;
//    
//    OverlayAnimationController *overlayAnimationController = [[OverlayAnimationController alloc] init];
//    return overlayAnimationController;
//}



- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    OverlayPresentationController *overlayPresentationController = [[OverlayPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return overlayPresentationController;
}




@end
