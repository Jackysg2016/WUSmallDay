//
//  WUExploreBeautyAlbumDetailViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/16.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreBeautyAlbumDetailViewController.h"
#import "WUExploreThemeModel.h"
#import "UIImage+Image.h"
#import "WUExploreEventModel.h"
#import "WUExploreEventCell.h"

@interface WUExploreBeautyAlbumDetailViewController ()<UITableViewDataSource>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *moreTableView;
@property (nonatomic, strong) WUExploreThemeModel *model;
@property (nonatomic, strong) UIButton *themeListBtn;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation WUExploreBeautyAlbumDetailViewController

- (instancetype)initWithModel:(WUExploreThemeModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.themeListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.themeListBtn setBackgroundImage:[UIImage imageNamed:@"themelist"] forState:UIControlStateNormal];
    [self.themeListBtn setBackgroundImage:[UIImage imageNamed:@"themeweb"] forState:UIControlStateSelected];
    [self.themeListBtn addTarget:self action:@selector(themeListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.themeListBtn.frame = CGRectMake(5, SCREEN_HEIGHT-55, 50, 50);
    [[[UIApplication sharedApplication].delegate window] addSubview:self.themeListBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.themeListBtn removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:0.99]] forBarMetrics:UIBarMetricsDefault];
    
    [self loadData];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.themeurl]]];
    [self.view addSubview:self.webView];
    
    
}

- (void)loadData {
    NSDictionary *data = [WUAppUtils dictionaryWithFileName:@"moreData.json"];
    self.dataArr = @[].mutableCopy;
    for (NSDictionary *dict in data[@"list"]) {
        WUExploreEventModel *model = [[WUExploreEventModel alloc] initWithDictionary:dict];
        [self.dataArr addObject:model];
    }
    [self.moreTableView reloadData];
}

- (UITableView *)moreTableView {
    if (!_moreTableView) {
        _moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _moreTableView.dataSource = self;
        [_moreTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WUExploreEventCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([WUExploreEventCell class])];
        _moreTableView.rowHeight = 252;
    }
    return _moreTableView;
}

- (void)themeListBtnClick:(UIButton *)button {
   
    if (button.selected == YES) {
        
        button.selected = NO;
        [UIView transitionFromView:self.moreTableView toView:self.webView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    }else {
        button.selected = YES;
        [UIView transitionFromView:self.webView toView:self.moreTableView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
    }
    
}

#pragma mark - UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WUExploreEventCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WUExploreEventCell class]) forIndexPath:indexPath];
    [cell updateUIWithModel:self.dataArr[indexPath.row]];
    return cell;
}



@end
