//
//  SEDViewContainerViewController.m
//  CustomContainerVCTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "SDEContainerViewController.h"
#import "ContainerTransitionContext.h"

@interface SDEContainerViewController ()
//按钮宽度
@property (nonatomic, assign) CGFloat kButtonSlotWidth;
//按钮高度
@property (nonatomic, assign) CGFloat kButtonSlotHeight;
//容器视图
@property (nonatomic, strong) UIView *privateContainerView;
//按钮标题数组
@property (nonatomic, strong) NSMutableArray *buttonTitles;
//转场上下文
@property (nonatomic, strong) ContainerTransitionContext *containerTransitionContext;

@end

@implementation SDEContainerViewController

- (void)loadView{
    
    self.kButtonSlotHeight = 64;
    
    UIView *rootView = [[UIView alloc] init];
    rootView.backgroundColor = [UIColor blackColor];
    rootView.opaque = YES;
    self.view = rootView;
    
    self.privateContainerView = [[UIView alloc] init];
    self.privateContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.privateContainerView.backgroundColor = [UIColor redColor];
    self.privateContainerView.opaque = YES;
    [rootView addSubview:self.privateContainerView];
    //给容器视图加约束
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [rootView addConstraint:width];
    [rootView addConstraint:height];
    [rootView addConstraint:left];
    [rootView addConstraint:top];
  
    self.buttonTabBar = [[UIView alloc] init];
    self.buttonTabBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.buttonTabBar.backgroundColor = [UIColor colorWithWhite:0.876 alpha:1.000];
    self.buttonTabBar.tintColor = [UIColor colorWithWhite:1.000 alpha:0.750];
    [rootView addSubview:self.buttonTabBar];
    
   //给buttonTabBar加约束
    NSLayoutConstraint *width1 = [NSLayoutConstraint constraintWithItem:self.buttonTabBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.privateContainerView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *height1 = [NSLayoutConstraint constraintWithItem:self.buttonTabBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_kButtonSlotHeight];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.buttonTabBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.privateContainerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.buttonTabBar attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual toItem:self.privateContainerView attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    
    [rootView addConstraint:width1];
    [rootView addConstraint:height1];
    [rootView addConstraint:centerX];
    [rootView addConstraint:centerY];
    //添加按钮
    [self addChildViewControllerButtons];
}

- (void)addChildViewControllerButtons{
    
    for (int i = 0; i < self.buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, _kButtonSlotWidth, _kButtonSlotHeight);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button addTarget:self action:@selector(TabButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonTabBar addSubview:button];
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.buttonTabBar attribute:NSLayoutAttributeLeading multiplier:1 constant:(i + 0.5) * _kButtonSlotWidth];
      
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual toItem:self.buttonTabBar attribute:NSLayoutAttributeCenterY multiplier:1 constant:15];
        [self.buttonTabBar addConstraint:centerX];
        [self.buttonTabBar addConstraint:centerY];
    }
    
    
}
//点击按钮
- (void)TabButtonTapped:(UIButton *)button{
    NSInteger tappedIndex = [self.buttonTabBar.subviews indexOfObject:button];
    if (tappedIndex != self.mySelectedIndex) {
        self.mySelectedIndex = tappedIndex;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //第一次转场
    [self transitionViewControllerFromIndex:NSNotFound toIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化
-(instancetype)initWithViewControllers:(NSArray *)viewControllers{
    if (self = [super init]) {
        self.viewControllers = viewControllers;
        self.kButtonSlotWidth = kScreenWidth / self.viewControllers.count;
        
        for (UIViewController *childVC in viewControllers) {
            NSString *title = childVC.title;
            [self.buttonTitles addObject:title];
            
            childVC.view.translatesAutoresizingMaskIntoConstraints = YES;
            childVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth & UIViewAutoresizingFlexibleHeight;
            //通知进行监听转场完毕
            [[NSNotificationCenter defaultCenter] addObserverForName:SDEContainerTransitionEndNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                self.containerTransitionContext = nil;
                self.buttonTabBar.userInteractionEnabled = YES;
                [self changeTabButtonAppearAtIndex:self.mySelectedIndex];
            }];
            
        }
    }
    return self;
}
- (NSMutableArray *)buttonTitles{
    if (_buttonTitles == nil) {
        _buttonTitles = [NSMutableArray array];
    }
    return _buttonTitles;
}

//重写setter方法,控制转场
- (void)setMySelectedIndex:(NSInteger)mySelectedIndex
{
    if (self.shouldReserve) {
        self.shouldReserve = NO;
    }else{
    
    [self transitionViewControllerFromIndex:self.mySelectedIndex toIndex:mySelectedIndex];
       
    }
    //赋值,一定不可少
     _mySelectedIndex = mySelectedIndex;
}

//逐渐改变按钮颜色
- (void)graduallyChangeTabButtonAppearWithFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex percent:(float)percent
{
    UIButton *fromBtn = [self.buttonTabBar.subviews objectAtIndex:fromIndex];
    UIButton *toBtn = [self.buttonTabBar.subviews objectAtIndex:toIndex];
    [fromBtn setTitleColor:[UIColor colorWithRed:1 green:percent blue:percent alpha:1] forState:UIControlStateNormal];
    [toBtn setTitleColor:[UIColor colorWithRed:1 green:1 - percent blue:1 - percent alpha:1] forState:UIControlStateNormal];
}
//(交互转场取消时)恢复
- (void)restoreSelectedIndex{
    self.shouldReserve = YES;
    self.mySelectedIndex = self.priorSelectedIndex;
}
//点击按钮时控制按钮的颜色
- (void)changeTabButtonAppearAtIndex:(NSInteger)selectedIndex{
    for (int i = 0; i < self.buttonTabBar.subviews.count; i++) {
        UIButton *button = self.buttonTabBar.subviews[i];
        if (i == selectedIndex) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}
//控制器转场
- (void)transitionViewControllerFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    
    if (self.viewControllers == nil || fromIndex == toIndex || fromIndex < 0 || toIndex >= self.viewControllers.count) {
        return;
    }
    //第一次进来时fromVC 为空,把toVC加到self中作为fromVC为下次使用
    if (fromIndex == NSNotFound) {
        UIViewController *selectedVC = self.viewControllers[toIndex];
        [self addChildViewController:selectedVC];
        [self.privateContainerView addSubview:selectedVC.view];
        [selectedVC didMoveToParentViewController:self];
        [self changeTabButtonAppearAtIndex:toIndex];
        return;
    }
    
    if (self.containerTransitionDelegate) {//如果代理不为空,则转场可以分为交互和非交互
        self.buttonTabBar.userInteractionEnabled = NO;
        
        UIViewController *fromVC = _viewControllers[fromIndex];
        UIViewController *toVC = _viewControllers[toIndex];
        
        self.containerTransitionContext = [[ContainerTransitionContext alloc] initWithContainerViewController:self containerView:self.privateContainerView fromViewController:fromVC toViewController:toVC];
        if (self.interactive) {
            //如果是滑动切换,要记录index,防止中途取消,以便恢复
            self.priorSelectedIndex = fromIndex;
            [self.containerTransitionContext startInteractiveTranstionWithDelegate:self.containerTransitionDelegate];
        }else{
            [self.containerTransitionContext startNonInteractiveTransitionWithDelegate:self.containerTransitionDelegate];
            [self changeTabButtonAppearAtIndex:toIndex];
        }
    }else{//如果代理为空,则只能点击转场,也没有滑动效果 这里就是把上一个控制器和视图移除,把新的控制器和视图加进来,然后改变按钮等
        UIViewController *priorSelectedVC = _viewControllers[fromIndex];
        [priorSelectedVC willMoveToParentViewController:nil];
        [priorSelectedVC.view removeFromSuperview];
        [priorSelectedVC removeFromParentViewController];
        
        UIViewController *newSelectedVC = _viewControllers[toIndex];
        [self addChildViewController:newSelectedVC];
        [self.privateContainerView addSubview:newSelectedVC.view];
        [newSelectedVC didMoveToParentViewController:self];
        [self changeTabButtonAppearAtIndex:toIndex];
    }
    
    
}


@end
