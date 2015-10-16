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
  
     [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UPDATE_IMAGE_CONSTRAINT object:nil userInfo:@{@"offsetY":[NSNumber numberWithFloat:scrollView.contentOffset.y]}];
    
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
