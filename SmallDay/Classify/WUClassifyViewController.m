//
//  WUClassifyViewController.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUClassifyViewController.h"

#import "WUClassifyCell.h"
#import "WUClassifyModel.h"

@interface WUClassifyViewController ()<UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation WUClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    [self loadData];
}

- (void)loadData {
    
    NSDictionary *data = [WUAppUtils dictionaryWithFileName:@"classifyData.json"];
    self.dataArr = @[].mutableCopy;
    for (NSDictionary *dict in data[@"list"]) {
        NSMutableArray *subDataArr = @[].mutableCopy;
        for (NSDictionary *subDict in dict[@"tags"]) {
            WUClassifyModel *model = [[WUClassifyModel alloc] initWithDictionary:subDict];
            [subDataArr addObject:model];
        }
        [self.dataArr addObject:subDataArr];
    }
    [self.collectionView reloadData];
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3, (SCREEN_WIDTH/3)*5/8+18);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WUClassifyCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([WUClassifyCell class])];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WUClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WUClassifyCell class]) forIndexPath:indexPath];
    [cell updateUIWithModel:self.dataArr[indexPath.section][indexPath.row]];
    return cell;
}

@end
