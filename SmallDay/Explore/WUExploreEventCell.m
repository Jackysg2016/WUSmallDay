//
//  WUExploreEventCell.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreEventCell.h"

@interface WUExploreEventCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation WUExploreEventCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIWithModel:(WUExploreEventModel *)model {
    
}

@end
