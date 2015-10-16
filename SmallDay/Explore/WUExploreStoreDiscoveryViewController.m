//
//  WUExploreStoreDiscoveryViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/13.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreStoreDiscoveryViewController.h"

#import "WUExploreEventModel.h"
#import "WUHtmlImgCell.h"
#import "WUHtmlTextCell.h"
#import "WUHtmlModel.h"

#define kHeadH SCREEN_WIDTH*5/8 //头视图的高度
#define kBarH 44

@interface WUExploreStoreDiscoveryViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WUExploreEventModel *model;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSLayoutConstraint *imgTopSpaceConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imgHeightConstraint;
@end

@implementation WUExploreStoreDiscoveryViewController

- (instancetype)initWithModel:(WUExploreEventModel *)model topSpaceConstraint:(NSLayoutConstraint *)topSpaceConstraint heightConstraint:(NSLayoutConstraint *)heightConstraint{
    if (self = [super init]) {
        self.model = model;
        self.imgTopSpaceConstraint= topSpaceConstraint;
        self.imgHeightConstraint = heightConstraint;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view .backgroundColor = [UIColor blueColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.dataArr = [WUHtmlModel parseHtml:self.model.mobileURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button setTitle:@"snfiosbdfi" forState:UIControlStateNormal];
//    button.frame = CGRectMake(20, 64, 200, 80);
//    button.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:button];
    
    
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
     
        _tableView.contentInset = UIEdgeInsetsMake(kHeadH+kBarH, 0, 0, 0);
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
    
    WUHtmlModel *model = self.dataArr[indexPath.row];
    if (model.isImg) {
        
        static NSString *imgCellId = @"imgCellId";
        WUHtmlImgCell *cell = [tableView dequeueReusableCellWithIdentifier:imgCellId];
        if (!cell) {
            cell = [WUHtmlImgCell htmlImgCell];
        }
        [cell updateUIWithModel:model];
        return cell;
    }else {
        static NSString *textCellId = @"textCellId";
        WUHtmlTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellId];
        if (!cell) {
            cell = [WUHtmlTextCell htmlTextCell];
        }
        [cell updateUIWithModel:model];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WUHtmlModel *model = self.dataArr[indexPath.row];
    if (model.isImg) {
        
        return model.imgHeight + 5;
        
    }else {
        NSLog(@"%d",model.isBold);
        if (model.isBold) {
            return 21;
        }else {
            return model.textHeight + 5;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
    CGFloat beginOffsetY = -(kHeadH + kBarH);
    CGFloat offsetY = scrollView.contentOffset.y - beginOffsetY;

    if (offsetY > 0) {//向上拖拽
        self.imgTopSpaceConstraint.constant = -offsetY;
        if (self.imgTopSpaceConstraint.constant <=beginOffsetY+64+44) {
            self.imgTopSpaceConstraint.constant = beginOffsetY+64+44;
        }
    }else {//向下拖拽
        
        self.imgHeightConstraint.constant = kHeadH - offsetY;
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
