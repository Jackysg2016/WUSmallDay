//
//  WUExploreBeautyDayDetailViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/13.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreBeautyDayDetailViewController.h"

#import "WUExploreEventModel.h"
#import <UIImageView+WebCache.h>
#import "WUExploreEventHeaderView.h"
#import "WUExploreStoreDiscoveryViewController.h"
#import "WUExploreStoreDetailViewController.h"

@interface WUExploreBeautyDayDetailViewController ()<UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet WUExploreEventHeaderView *headerTitleView;
@property (nonatomic, strong) WUExploreEventModel *model;

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSArray *pageContent;

@end

@implementation WUExploreBeautyDayDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self creatBarButtonItems];
    [self updateUIWithModel:self.model];
    
    [self createPageViewController];

}

- (void)setDataModel:(WUExploreEventModel *)model {
    self.model = model;
}

- (void)createPageViewController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource = self;
    self.pageController.view.frame = self.view.bounds;
    
    WUExploreStoreDiscoveryViewController *discoveryVc = [[WUExploreStoreDiscoveryViewController alloc] initWithModel:self.model];
    WUExploreStoreDetailViewController *detailVc = [[WUExploreStoreDetailViewController alloc] initWithModel:self.model];
    self.pageContent = @[discoveryVc,detailVc];
    [self.pageController setViewControllers:@[discoveryVc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.view sendSubviewToBack:self.pageController.view];
    
}

#pragma mark - BarButtonItems
- (void)creatBarButtonItems {
    self.navigationItem.leftBarButtonItems = [WUAppUtils createBackButtonWithTarget:self selector:@selector(backAction:)];
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, 44.f, 44.f);
    [collectBtn setImage:[UIImage imageNamed:@"collect_0"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 44.f, 44.f);
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"share_0"] forState:UIControlStateNormal];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = -8;
    self.navigationItem.rightBarButtonItems = @[fixedItem,shareItem,collectItem];
}

#pragma mark - showData
- (void)updateUIWithModel:(WUExploreEventModel *)model {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.imgs[0]] placeholderImage:nil];
}



#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.pageContent indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index >= self.pageContent.count) {
        return nil;
    }
    return self.pageContent[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.pageContent indexOfObject:viewController];
    if (index == 0 || index ==NSNotFound) {
        return nil;
    }
    index--;
    if (index >= self.pageContent.count) {
        return nil;
    }
    return self.pageContent[index];
}


#pragma mark - Action
//收藏
- (void)collect:(id)sender {
    
}

//分享
- (void)share:(id)sender {
    
}


@end
