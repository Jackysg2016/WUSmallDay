//
//  WUExploreStoreDetailCell.m
//  SmallDay
//
//  Created by wuqh on 15/10/16.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreStoreDetailCell.h"
#import "WUExploreEventModel.h"

@interface WUExploreStoreDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *biaoqianBtn;


@end

@implementation WUExploreStoreDetailCell

+ (WUExploreStoreDetailCell *)exploreStoreDetailCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIWihtModel:(WUExploreEventModel *)model index:(NSInteger)index {
    switch (index) {
        case 0:
        {
            self.titleLabel.text = @"营业时间";
            self.contentLabel.text = @"每天 9:00 - 20:00 周三休息";
            self.biaoqianBtn.hidden = YES;
        }
            break;
        case 1:
        {
            self.titleLabel.text = @"店铺电话";
            self.contentLabel.text = model.telephone;
            self.biaoqianBtn.hidden = NO;
            [self.biaoqianBtn setTitle:@"拨打" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.titleLabel.text = @"店铺地址";
            self.contentLabel.text = model.address;
            self.biaoqianBtn.hidden = NO;
            [self.biaoqianBtn setTitle:@"导航" forState:UIControlStateNormal];
        }
            break;
            
            
        default:
            break;
    }
}

@end
