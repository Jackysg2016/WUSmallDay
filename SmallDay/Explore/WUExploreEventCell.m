//
//  WUExploreEventCell.m
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUExploreEventCell.h"

#import "WUExploreEventModel.h"
#import <UIImageView+WebCache.h>

@interface WUExploreEventCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end

@implementation WUExploreEventCell

+ (instancetype)exploreEventCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"WUExploreEventCell" owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIWithModel:(WUExploreEventModel *)model {
    
    self.titleLabel.text = model.title;
//    NSLog(@"%@",self.titleLabel.text);
    self.feelTitleLabel.text = model.feeltitle;
    self.addressLabel.text = model.address;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.imgs[0]] placeholderImage:nil];
    
}

@end
