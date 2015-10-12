//
//  WUExploreTitleView.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreTitleView.h"

@interface WUExploreTitleView()

@property (weak, nonatomic) IBOutlet UIButton *beautyDayButton;
@property (weak, nonatomic) IBOutlet UIButton *beautyAlbumButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;



@end

@implementation WUExploreTitleView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.beautyDayButton.selected = YES;
}

+ (instancetype)exploreTitleView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WUExploreTitleView" owner:self options:nil] lastObject];
}

#pragma mark Target Action
- (IBAction)beautyDayButtonClick:(UIButton *)sender {
    self.beautyDayButton.selected = YES;
    self.beautyAlbumButton.selected = NO;
    [self selectButtonAtIndex:0];
}

- (IBAction)beautyAlbumButtonClick:(UIButton *)sender {
    self.beautyAlbumButton.selected = YES;
    self.beautyDayButton.selected = NO;
    [self selectButtonAtIndex:1];
}

- (void)selectButtonAtIndex:(NSInteger)index {
    
    CGFloat x = index == 0 ? 0 :self.frame.size.width/2;
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bottomLine.frame = CGRectMake(x, 43, self.bottomLine.bounds.size.width, self.bottomLine.bounds.size.height);
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(exploreTitleView:didSelectedItemAtIndex:)]) {
            [self.delegate exploreTitleView:self didSelectedItemAtIndex:index];
        }
    }];
}

- (void)selectItemAtIndex:(NSInteger)index {
    if (index == 0) {
        [self beautyDayButtonClick:self.beautyDayButton];
    }else {
        [self beautyAlbumButtonClick:self.beautyAlbumButton];
    }
}


@end
