
//
//  ContainerTransitionContext.m
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//
#import "SDEContainerViewController.h"
#import "ContainerTransitionContext.h"
#import "ContainerTransitionDelegate.h"
#import "SDEPercentInteractiveTransition.h"

@interface ContainerTransitionContext ()

@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> animationController;
@property (nonatomic, unsafe_unretained) UIViewController *privateFromViewController;
@property (nonatomic, unsafe_unretained) UIViewController *privateToViewController;
@property (nonatomic, unsafe_unretained) SDEContainerViewController *privateContainerViewController;
@property (nonatomic, unsafe_unretained) UIView *privateContainerView;
@property (nonatomic, assign) BOOL interactive;//控制是否交互
@property (nonatomic, assign) BOOL isCancelled;//是否取消
@property (nonatomic, assign) NSUInteger fromIndex;
@property (nonatomic, assign) NSUInteger toIndex;
@property (nonatomic, assign) float transitionDuration;
@property (nonatomic, assign) float transitionPercent;

@end
@implementation ContainerTransitionContext
//初始化
- (instancetype)initWithContainerViewController:
(SDEContainerViewController *)containerViewController
                                  containerView:(UIView *)containerView
                             fromViewController:(UIViewController *)fromVC
                               toViewController:(UIViewController *)toVC
{
    if (self == [super init]) {
        self.privateContainerViewController = containerViewController;
        self.privateContainerView = containerView;
        self.privateFromViewController = fromVC;
        self.privateToViewController = toVC;
        self.fromIndex = [containerViewController.viewControllers indexOfObject:fromVC];
        self.toIndex = [containerViewController.viewControllers indexOfObject:toVC];
        
         //每次转场开始前都会生成这个对象，调整 toView 的尺寸适用屏幕
        self.privateToViewController.view.frame = self.privateContainerView.bounds;
    }
    return self;
}

#pragma mark - 自定义的方法
//开始交互转场
- (void)startInteractiveTranstionWithDelegate:(ContainerTransitionDelegate *)delegate
{
    self.animationController = [delegate containerController:self.privateContainerViewController fromViewController:self.privateFromViewController toViewController:self.privateToViewController];
    self.transitionDuration = [self.animationController transitionDuration:self];
    
    if (self.privateContainerViewController.interactive) {
        
        SDEPercentInteractiveTransition *interactionController = [delegate containerController:self.privateContainerViewController interactionControllerForAnimationController:self.animationController];
        
        if (interactionController) {
            [interactionController startInteractiveTransition:self];
        }else{
            NSLog(@"Need for interaction controller for interactive transition.");
        }
        
    }else{
         NSLog(@"ContainerTransitionContext's Property 'interactive' must be true before starting interactive transiton");
    }
    
    
}
//开始非交互转场
- (void)startNonInteractiveTransitionWithDelegate:(ContainerTransitionDelegate *)delegate
{
    self.animationController = [delegate containerController:self.privateContainerViewController fromViewController:self.privateFromViewController toViewController:self.privateToViewController];
    self.transitionDuration = [self.animationController transitionDuration:self];
    
    [self activateNonInteractiveTransition];
}


//交互转场(滑动)
- (void)activateInteractiveTransition
{
    self.interactive = YES;
    self.isCancelled = NO;
    [self.privateContainerViewController addChildViewController:self.privateToViewController];
    self.privateContainerView.layer.speed = 0;
    [self.animationController animateTransition:self];
}

//非交互转场(点击)
- (void)activateNonInteractiveTransition
{
    self.interactive = NO;
    self.isCancelled = NO;
    [self.privateToViewController willMoveToParentViewController:self.privateContainerViewController];
    [self.animationController animateTransition:self];
}


- (void)removeFakeFromView:(UIView *)fakeView{
    [fakeView removeFromSuperview];
}


- (void)fixBeginTimeBug{
    self.privateContainerView.layer.beginTime = 0.0;
}

//取消转场时用来恢复视图
- (void)reverseCurrentAnimation:(CADisplayLink *)displayLink{
    
    CFTimeInterval timeOffset = self.privateContainerView.layer.timeOffset - displayLink.duration;

    //不停的调用这个方法,让视图恢复
    
    if (timeOffset > 0) {
        self.privateContainerView.layer.timeOffset = timeOffset;
        self.transitionPercent = timeOffset / self.transitionDuration;
        [self.privateContainerViewController graduallyChangeTabButtonAppearWithFromIndex:self.fromIndex toIndex:self.toIndex percent:self.transitionPercent];
    }else{//当timeOffset<=0时,说明已经恢复原来位置了,让displayLink失效
        [displayLink invalidate];
        self.privateContainerView.layer.timeOffset = 0.0;
        self.privateContainerView.layer.speed = 1.0;
         [self.privateContainerViewController graduallyChangeTabButtonAppearWithFromIndex:self.fromIndex toIndex:self.toIndex percent:0];
        
        //修复闪屏Bug: speed 恢复为1后，动画会立即跳转到它的最终状态，而 fromView 的最终状态是移动到了屏幕之外，因此在这里添加一个假的掩人耳目。
        //为何不等 completion block 中恢复 fromView 的状态后再恢复 containerView.layer.speed，事实上那样做无效，原因未知。
        UIView *fakeFromView = [self.privateFromViewController.view snapshotViewAfterScreenUpdates:NO];
        [self.privateContainerView addSubview:fakeFromView];
        [self performSelector:@selector(removeFakeFromView:) withObject:fakeFromView afterDelay:1/60];
        
    }
}


- (void)transitionEnd{
    if (self.animationController != nil && [self.animationController respondsToSelector:@selector(animationEnded:)]) {
        [self.animationController animationEnded:!self.isCancelled];
    }
    if (self.isCancelled) {
        [self.privateContainerViewController restoreSelectedIndex];
        self.isCancelled = NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SDEContainerTransitionEndNotification object:self];
}

/*
 自定义转场上下文,系统提供转场上下文应该实现的方法可以引导你,遵从系统提供的协议UIViewControllerContextTransitioning逐一实现
 */
#pragma mark - 实现 UIViewControllerContextTransitioning 协议方法
//1返回转场容器视图
- (nullable UIView *)containerView{
    return self.privateContainerView;
}

//2是否支持动画
- (BOOL)isAnimated{
    if (self.animationController != nil) {
        return YES;
    }
    return NO;
}
//3是否支持交互
- (BOOL)isInteractive{
    
    return self.interactive;
}
//4是否取消了转场
- (BOOL)transitionWasCancelled{
    return self.isCancelled;
}
//5转场的模式
- (UIModalPresentationStyle)presentationStyle{
    return UIModalPresentationCustom;
}
//6更新转场进度(用在交互转场中)
- (void)updateInteractiveTransition:(CGFloat)percentComplete{
    if (self.animationController != nil && self.interactive) {
        self.transitionPercent = percentComplete;
        self.privateContainerView.layer.timeOffset = percentComplete * self.transitionDuration;
        //改变按钮的颜色
        [self.privateContainerViewController graduallyChangeTabButtonAppearWithFromIndex:self.fromIndex toIndex:self.toIndex percent:percentComplete];
        
    }
}
//7完成交互转场
- (void)finishInteractiveTransition{
    self.interactive = NO;
    CFTimeInterval pauseTime = self.privateContainerView.layer.timeOffset;
    
    self.privateContainerView.layer.speed = 1.0;
    self.privateContainerView.layer.timeOffset = 0.0;
   
    CFTimeInterval timeSincePause = [self.privateContainerView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    self.privateContainerView.layer.beginTime = timeSincePause;
    
    

    
    //当 SDETabBarViewController 作为一个子 VC 内嵌在其他容器 VC 内，比如 NavigationController 里时，在 SDETabBarViewController 内完成一次交互转场后
    //在外层的 NavigationController push 其他 VC 然后 pop 返回时，且仅限于交互控制，会出现 containerView 不见的情况，pop 完成后就恢复了。
    //根源在于此时 beginTime 被修改了，在转场结束后恢复为 0 就可以了。解决灵感来自于如果没有一次完成了交互转场而全部是中途取消的话就不会出现这个 Bug。
    
    CFTimeInterval remainingTime = (1 - self.transitionPercent) * self.transitionDuration;
    
    [self performSelector:@selector(fixBeginTimeBug) withObject:nil afterDelay:remainingTime];
}
//8取消交互转场
- (void)cancelInteractiveTransition{
    self.interactive = NO;
    self.isCancelled = YES;
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(reverseCurrentAnimation:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
//9转场结束
- (void)completeTransition:(BOOL)didComplete{
    if (didComplete) {
        [self.privateToViewController didMoveToParentViewController:self.privateContainerViewController];
        [self.privateFromViewController willMoveToParentViewController:nil];
        [self.privateFromViewController.view removeFromSuperview];
        [self.privateFromViewController removeFromParentViewController];
    }else{
        [self.privateToViewController didMoveToParentViewController:self.privateContainerViewController];
        [self.privateToViewController willMoveToParentViewController:nil];
        [self.privateToViewController.view removeFromSuperview];
        [self.privateToViewController removeFromParentViewController];
    }
    [self transitionEnd];
}

//10获取转场控制器
- (nullable __kindof UIViewController *)viewControllerForKey:(NSString *)key
{
    if ([key isEqualToString:UITransitionContextFromViewControllerKey]) {
        return self.privateFromViewController;
    }
    if ([key isEqualToString:UITransitionContextToViewControllerKey]) {
        return self.privateToViewController;
    }
    return nil;
}
//11获取转场控制器视图
- (nullable __kindof UIView *)viewForKey:(NSString *)key{
    if (kiOS8Later) {
        if ([key isEqualToString:UITransitionContextFromViewKey]) {
            return self.privateFromViewController.view;
        }
        if ([key isEqualToString:UITransitionContextToViewKey]) {
            return self.privateToViewController.view;
        }
        return nil;
    };
    return nil;
}
//12目标转换
- (CGAffineTransform)targetTransform{
    return CGAffineTransformIdentity;
}
//13开始frame
- (CGRect)initialFrameForViewController:(UIViewController *)vc
{
    return CGRectZero;
}
//14结束frame
- (CGRect)finalFrameForViewController:(UIViewController *)vc{
    return vc.view.frame;
}







@end
