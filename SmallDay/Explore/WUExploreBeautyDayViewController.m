//
//  WUExploreBeautyDayViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreBeautyDayViewController.h"

#import "WUExploreEventCell.h"
#import "WUExploreThemeCell.h"
#import "WUExploreEventModel.h"
#import "WUExploreThemeModel.h"
#import "WUExploreBeautyDayDetailViewController.h"
#import "WUExploreBeautyAlbumDetailViewController.h"


@interface WUExploreBeautyDayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation WUExploreBeautyDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    [self loadData];
}

- (void)loadData {
    NSDictionary *data = [WUAppUtils dictionaryWithFileName:@"beautyDayData1.json"];
    self.dataArr = @[].mutableCopy;
    for (NSDictionary *dict in data[@"list"]) {
        
        if ([dict[@"events"] count] > 0) {
            
            WUExploreEventModel *model = [[WUExploreEventModel alloc] initWithDictionary:dict[@"events"][0]];
            [self.dataArr addObject:model];
            
        }
        if ([dict[@"themes"] count] > 0) {
            WUExploreThemeModel *model = [[WUExploreThemeModel alloc] initWithDictionary:dict[@"themes"][0]];
            [self.dataArr addObject:model];
        }
        
    }
    [self.tableView reloadData];
}

#pragma mark - UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.dataArr[indexPath.row] isKindOfClass:[WUExploreEventModel class]]) {
        static NSString *identifier = @"eventCell";
        WUExploreEventCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (!cell) {
            cell = [WUExploreEventCell exploreEventCell];
        }
        [cell updateUIWithModel:self.dataArr[indexPath.row]];
        return cell;
        
    }else {
        static NSString *identifier = @"themeCell";
        WUExploreThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [WUExploreThemeCell exploreThemeCell];
        }
        [cell updateUIWithModel:self.dataArr[indexPath.row]];
        return cell;
    }

}

#pragma mark - UITableViewDelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataArr[indexPath.row] isKindOfClass:[WUExploreEventModel class]]) {
        return 252;
    }else {
        return 205;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.dataArr[indexPath.row] isKindOfClass:[WUExploreEventModel class]]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Explore" bundle:nil];
        WUExploreBeautyDayDetailViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"WUExploreBeautyDayDetailViewController"];
        [vc setDataModel:self.dataArr[indexPath.row]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        WUExploreBeautyAlbumDetailViewController *vc = [[WUExploreBeautyAlbumDetailViewController alloc] initWithModel:self.dataArr[indexPath.row]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



@end


