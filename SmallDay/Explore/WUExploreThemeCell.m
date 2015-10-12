//
//  WUExploreThemeCell.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreThemeCell.h"
#import "WUExploreThemeModel.h"
#import <UIImageView+WebCache.h>

@interface WUExploreThemeCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation WUExploreThemeCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIWithModel:(WUExploreThemeModel *)model {
    self.titleLabel.text = model.title;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
}

@end
