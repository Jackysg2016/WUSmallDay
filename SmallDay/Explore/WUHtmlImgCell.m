

//
//  WUHtmlImgCell.m
//  SmallDay
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUHtmlImgCell.h"
#import "WUHtmlModel.h"
#import <UIImageView+WebCache.h>

@interface WUHtmlImgCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end

@implementation WUHtmlImgCell

+ (instancetype)htmlImgCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIWithModel:(WUHtmlModel *)model {
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];
}

@end
