

//
//  SecondCollectionViewController.m
//  CollectionViewControllerLayoutTransition
//
//  Created by zhekexinxi on 16/5/24.
//  Copyright © 2016年 刘士伟. All rights reserved.
//

#import "SecondCollectionViewController.h"


@interface CollectionViewDataSource : NSObject<UICollectionViewDataSource>
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, assign) NSInteger cellCount;
+ (instancetype)shareCollectionViewDataSource;
@end

@interface SecondCollectionViewController ()
@property (nonatomic, strong) CollectionViewDataSource *collectionDataSource;
@end

@implementation SecondCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
   
    // Do any additional setup after loading the view.
    
    self.collectionDataSource = [CollectionViewDataSource shareCollectionViewDataSource];
    
    self.collectionView.dataSource = self.collectionDataSource;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(indexPath.item * 10, indexPath.item * 10);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    SecondCollectionViewController *secondCollectionVC = [[SecondCollectionViewController alloc] initWithCollectionViewLayout:layout];
    secondCollectionVC.collectionDataSource = [CollectionViewDataSource shareCollectionViewDataSource];
    secondCollectionVC.collectionDataSource.sectionCount = 2;
    
    int random = arc4random() % 10 + 5;
    
    NSLog(@"%d", random);
    secondCollectionVC.collectionDataSource.cellCount = random;
    
    //最重要的一句
    secondCollectionVC.useLayoutToLayoutNavigationTransitions = YES;
    [self.navigationController pushViewController:secondCollectionVC animated:YES];
}

@end



@implementation CollectionViewDataSource
+ (instancetype)shareCollectionViewDataSource
{
    static CollectionViewDataSource *dataSource = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSource = [[CollectionViewDataSource alloc] init];
        
    });
    
    return dataSource;
}
- (instancetype)init
{
    if (self = [super init]) {
        self.cellCount = 15;
        self.sectionCount = 2;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.sectionCount;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0){
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}


@end


















