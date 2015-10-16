//
//  WUExploreEventHeaderView.m
//  SmallDay
//
//  Created by wuqh on 15/10/13.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreEventHeaderView.h"



@interface WUExploreEventHeaderView()

@property (nonatomic, strong) UIButton *discoveryBtn;
@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation WUExploreEventHeaderView

//static CGFloat btnWidth = SCREEN_WIDTH/2;
//static CGFloat btnHeigth = 64;

- (void)awakeFromNib {
    [self createUI];
}

#pragma mark -UI

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.discoveryBtn];
    [self addSubview:self.detailBtn];
    [self addSubview:self.bottomLine];
    UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-1)/2, self.bounds.size.height/3, 1, self.bounds.size.height/3)];
    centerLine.backgroundColor = [UIColor grayColor];
    [self addSubview:centerLine];
}

- (UIButton *)discoveryBtn {
    if (!_discoveryBtn) {
        _discoveryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _discoveryBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, self.bounds.size.height);
        [_discoveryBtn setTitle:@"店·发现" forState:UIControlStateNormal];
        [_discoveryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_discoveryBtn addTarget:self action:@selector(discoveryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _discoveryBtn;
}

- (UIButton *)detailBtn {
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, self.bounds.size.height);
        [_detailBtn setTitle:@"店·详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailBtn;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        CGFloat interval = 10.f;
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(interval, self.frame.size.height - 1, SCREEN_WIDTH/2 - interval*2, 1)];
        _bottomLine.backgroundColor = [UIColor blackColor];
    }
    return _bottomLine;
}

#pragma mark - Target Action
- (void)discoveryBtnClick:(UIButton *)button {
    self.discoveryBtn.selected = YES;
    self.detailBtn.selected = NO;
    [self selectButtonAtIndex:0];
}

- (void)detailBtnClick:(UIButton *)button {
    self.detailBtn.selected = YES;
    self.discoveryBtn.selected = NO;
    [self selectButtonAtIndex:1];
}

- (void)selectButtonAtIndex:(NSInteger)index {
    
    CGFloat x = index == 0 ? 0 :self.frame.size.width/2;
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bottomLine.frame = CGRectMake(x, 43, self.bottomLine.bounds.size.width, self.bottomLine.bounds.size.height);
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(exploreEventHeaderView:didSelectedItemAtIndex:)]) {
            [self.delegate exploreEventHeaderView:self didSelectedItemAtIndex:index];
        }
    }];
}

- (void)selectItemAtIndex:(NSInteger)index {
    if (index == 0) {
        [self discoveryBtnClick:self.discoveryBtn];
        
    }else {
        [self detailBtnClick:self.detailBtn];
    }
}





@end
