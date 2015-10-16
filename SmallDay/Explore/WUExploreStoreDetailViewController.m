//
//  WUExploreStoreDetailViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/13.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreStoreDetailViewController.h"

#import "WUExploreEventModel.h"
#import "WUExploreStoreDetailCell.h"

#define kHeadH SCREEN_WIDTH*5/8 //头视图的高度
#define kBarH 44

@interface WUExploreStoreDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) WUExploreEventModel *model;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WUExploreStoreDetailViewController

- (instancetype)initWithModel:(WUExploreEventModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tableView];
 
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(kHeadH + kBarH, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WUExploreStoreDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([WUExploreStoreDetailCell class])];
        _tableView.rowHeight = 62;
        _tableView.tableFooterView = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = [NSString stringWithFormat:@"「 %@ 」",self.model.remark];
        _tableView.tableHeaderView = label;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WUExploreStoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WUExploreStoreDetailCell class]) forIndexPath:indexPath];
    [cell updateUIWihtModel:self.model index:indexPath.row];
    return cell;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UPDATE_IMAGE_CONSTRAINT object:nil userInfo:@{@"offsetY":[NSNumber numberWithFloat:scrollView.contentOffset.y]}];
    
}


@end
