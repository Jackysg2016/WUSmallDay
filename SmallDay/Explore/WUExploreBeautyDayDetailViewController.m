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
#import "UIImage+Image.h"

#define kHeadH SCREEN_WIDTH*5/8 //头视图的高度
#define kBarH 44

@interface WUExploreBeautyDayDetailViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,WUExploreEventHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet WUExploreEventHeaderView *headerTitleView;
@property (nonatomic, strong) WUExploreEventModel *model;

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSArray *pageContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightConstraint;

@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *backBtn;



@end

@implementation WUExploreBeautyDayDetailViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.imgHeightConstraint.constant = SCREEN_WIDTH *5/8;
//
    self.headerTitleView.delegate = self;
    [self.headerTitleView selectItemAtIndex:0];
    [self creatBarButtonItems];
    [self updateUIWithModel:self.model];
    
    [self createPageViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImageConstraint:) name:NOTIFICATION_UPDATE_IMAGE_CONSTRAINT object:nil];

}

- (void)updateImageConstraint:(NSNotification *)nf {
#if 0
    CGFloat beginOffsetY = -(kHeadH + kBarH);
    CGFloat offsetY = [nf.userInfo[@"offsetY"] floatValue] - beginOffsetY;
    
    if (offsetY > 0) {//向上拖拽
        self.topSpaceConstraint.constant = -offsetY;
        if (self.topSpaceConstraint.constant <=beginOffsetY+64+44) {
            self.topSpaceConstraint.constant = beginOffsetY+64+44;
        }
        
        CGFloat alpha = offsetY/(kHeadH-64);
        if (alpha >= 1) {
            alpha =0.99;
        }
//        self.navigationController.navigationBar.alpha = alpha;
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        NSLog(@"%f",alpha);

        
    }else {//向下拖拽
        
        self.imgHeightConstraint.constant = kHeadH - offsetY;
    }
#else
    CGFloat offsety = -(kHeadH + kBarH)-[nf.userInfo[@"offsetY"] floatValue]  ;
    //    CGFloat height = kHeadH + offsety;
    //    NSLog(@"%f",SCREEN_WIDTH*5/8);
    //    NSLog(@"%f",height);
    CGFloat offsety2 = -(kHeadH + kBarH)-[nf.userInfo[@"offsetY"] floatValue];
    CGFloat offsety3 = -(kHeadH + kBarH)-[nf.userInfo[@"offsetY"] floatValue];
    
    //设置top
    if (offsety<=-(kHeadH-64)) {
        offsety = -(kHeadH-64);
    }
    if (offsety>0) {
        offsety = 0;
    }
    self.topSpaceConstraint.constant = offsety;
    //设置Height
    if (offsety2<=0) {
        offsety2 = 0;
    }
    self.imgHeightConstraint.constant = kHeadH+offsety2;
    //设置导航懒透明度
    CGFloat alpha = -offsety3/(kHeadH - 64);
    if (alpha>=1) {
        alpha = 0.99;
        [self.collectBtn setImage:[UIImage imageNamed:@"collect_1"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"share_1"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"back_1"] forState:UIControlStateNormal];
        
        
    }else {
        [self.collectBtn setImage:[UIImage imageNamed:@"collect_0"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"share_0"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"back_0"] forState:UIControlStateNormal];
    }
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

#endif
    
    
}

- (void)setDataModel:(WUExploreEventModel *)model {
    self.model = model;
}

- (void)createPageViewController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    self.pageController.view.frame = self.view.bounds;
    
    WUExploreStoreDiscoveryViewController *discoveryVc = [[WUExploreStoreDiscoveryViewController alloc] initWithModel:self.model topSpaceConstraint:self.topSpaceConstraint heightConstraint:self.imgHeightConstraint];
    WUExploreStoreDetailViewController *detailVc = [[WUExploreStoreDetailViewController alloc] initWithModel:self.model];
    self.pageContent = @[discoveryVc,detailVc];

    [self.pageController setViewControllers:@[discoveryVc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
 
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.view sendSubviewToBack:self.pageController.view];
//    [self.pageController didMoveToParentViewController:self];
    
}

#pragma mark - BarButtonItems
- (void)creatBarButtonItems {
    self.navigationItem.leftBarButtonItems = [self createBackBarButtonItems];
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn = collectBtn;
    collectBtn.frame = CGRectMake(0, 0, 44.f, 44.f);
    [collectBtn setImage:[UIImage imageNamed:@"collect_0"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn = shareBtn;
    shareBtn.frame = CGRectMake(0, 0, 44.f, 44.f);
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"share_0"] forState:UIControlStateNormal];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = -8;
    self.navigationItem.rightBarButtonItems = @[fixedItem,shareItem,collectItem];
}

- (NSArray *)createBackBarButtonItems {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn = barButton;
    barButton.frame = CGRectMake(0, 0, 44.f, 44.f);
    [barButton setImage:[UIImage imageNamed:@"back_2"] forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -16;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    NSArray *items = @[negativeSpacer,barButtonItem];
    
    return items;
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

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (finished) {
        UIViewController *currentViewController = (UIViewController *)[pageViewController.viewControllers objectAtIndex:0];
        NSInteger curIndex = [self.pageContent indexOfObject:currentViewController];
        if (curIndex != NSNotFound) {
            [self.headerTitleView selectItemAtIndex:curIndex];
        }
    }
}


#pragma mark - Action
//收藏
- (void)collect:(id)sender {
    
}

//分享
- (void)share:(id)sender {
    
}

#pragma mark - WUExploreEventHeaderViewDelegate
- (void)exploreEventHeaderView:(WUExploreEventHeaderView *)exploreEventHeaderView didSelectedItemAtIndex:(NSInteger)index {
    NSUInteger currentIndex = [self.pageContent indexOfObject:[self.pageController.viewControllers lastObject]];
    
    if (index == currentIndex) return;
    
    UIPageViewControllerNavigationDirection direction = index > currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    
    [self.pageController setViewControllers:@[self.pageContent[index]]
                                      direction:direction
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         
                                     }];
}


@end
