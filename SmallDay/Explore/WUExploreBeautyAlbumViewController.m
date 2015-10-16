//
//  WUExploreBeautyAlbumViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreBeautyAlbumViewController.h"

#import "WUExploreThemeCell.h"
#import "WUExploreThemeModel.h"
#import "WUExploreBeautyAlbumDetailViewController.h"

@interface WUExploreBeautyAlbumViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation WUExploreBeautyAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)loadData {
    self.dataArr = @[].mutableCopy;
    NSDictionary *data = [WUAppUtils dictionaryWithFileName:@"beautyAlbumData.json"];
    for (NSDictionary *dict in data[@"list"]) {
        WUExploreThemeModel *model = [[WUExploreThemeModel alloc] initWithDictionary:dict];
        [self.dataArr addObject:model];
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"WUExploreThemeCell" bundle:nil] forCellReuseIdentifier:@"themeCell"];
        _tableView.rowHeight = 205;
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
    WUExploreThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themeCell" forIndexPath:indexPath];
    [cell updateUIWithModel:self.dataArr[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WUExploreBeautyAlbumDetailViewController *vc = [[WUExploreBeautyAlbumDetailViewController alloc] initWithModel:self.dataArr[indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
