//
//  WUExploreViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreViewController.h"

#import "WUExploreTitleView.h"
#import "WUExploreBeautyDayViewController.h"
#import "WUExploreBeautyAlbumViewController.h"

@interface WUExploreViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,WUExploreTitleViewDelegate>

@property (nonatomic, strong) WUExploreTitleView *exploreTitleView;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *viewControllers;


@end

@implementation WUExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置navigationBar的titleView
    self.navigationItem.titleView = self.exploreTitleView;
    
    //viewControllers
    WUExploreBeautyDayViewController *beautyDayViewController = [[WUExploreBeautyDayViewController alloc] init];
    beautyDayViewController.view.frame = self.view.bounds;
    self.viewControllers = @[beautyDayViewController,[NSNull null]].mutableCopy;
    
    //初始化self.pageViewController
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = self.view.bounds;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    [self.pageViewController didMoveToParentViewController:self];
    [self.exploreTitleView selectItemAtIndex:0   ];
    
    
}


#pragma mark - UI
- (WUExploreTitleView *)exploreTitleView {
    if (!_exploreTitleView) {
        _exploreTitleView = [WUExploreTitleView exploreTitleView];
        _exploreTitleView.frame = CGRectMake(0, 0, 160, 44);
        _exploreTitleView.delegate = self;
    }
    return _exploreTitleView;
}

- (WUExploreBeautyAlbumViewController *)beautyAlbumViewController {
    WUExploreBeautyAlbumViewController *beautyAlbumViewController = [[WUExploreBeautyAlbumViewController alloc] init];
    beautyAlbumViewController.view.frame = self.view.bounds;
    return beautyAlbumViewController;
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == (self.viewControllers.count-1)) {
        return nil;
    }
    id controller = [self.viewControllers objectAtIndex:index+1];
    if ([controller isKindOfClass:[NSNull class]]) {
        [self.viewControllers replaceObjectAtIndex:index+1 withObject:[self beautyAlbumViewController]];
    }
    
    return [self.viewControllers objectAtIndex:index+1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return [self.viewControllers objectAtIndex:index-1];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (finished) {
        UIViewController *currentViewController = (UIViewController *)[pageViewController.viewControllers objectAtIndex:0];
        NSInteger curIndex = [self.viewControllers indexOfObject:currentViewController];
        if (curIndex != NSNotFound) {
            [self.exploreTitleView selectItemAtIndex:curIndex];
        }
    }
}

#pragma mark - WUExploreTitleViewDelegate
- (void)exploreTitleView:(WUExploreTitleView *)exploreTitleView didSelectedItemAtIndex:(NSInteger)index {
    
    NSUInteger currentIndex = [self.viewControllers indexOfObject:[self.pageViewController.viewControllers lastObject]];
    
    if (index == currentIndex) return;
    
    UIPageViewControllerNavigationDirection direction = index > currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    
    id controller = [self.viewControllers objectAtIndex:index];
    if ([controller isKindOfClass:[NSNull class]]) {
        [self.viewControllers replaceObjectAtIndex:index withObject:[self beautyAlbumViewController]];
    }
    [self.pageViewController setViewControllers:@[self.viewControllers[index]]
                                  direction:direction
                                   animated:YES
                                 completion:^(BOOL finished) {
                                     
                                 }];
    
}

@end
