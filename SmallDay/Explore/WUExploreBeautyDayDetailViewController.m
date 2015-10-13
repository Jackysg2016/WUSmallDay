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

@interface WUExploreBeautyDayDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet WUExploreEventHeaderView *headerTitleView;
@property (nonatomic, strong) WUExploreEventModel *model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WUExploreBeautyDayDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self creatBarButtonItems];
    [self updateUIWithModel:self.model];
    [self.tableView setContentInset:UIEdgeInsetsMake(self.headerImageView.bounds.size.height+self.headerTitleView.bounds.size.height, 0, 0, 0)];
    
    
}

- (void)setDataModel:(WUExploreEventModel *)model {
    self.model = model;
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

#pragma mark - Action
//收藏
- (void)collect:(id)sender {
    
}

//分享
- (void)share:(id)sender {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"ld",indexPath.row];
    return cell;
}

@end
