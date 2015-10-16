//
//  WUClassifyCell.m
//  SmallDay
//
//  Created by wuqh on 15/10/16.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUClassifyCell.h"
#import <UIImageView+WebCache.h>
#import "WUClassifyModel.h"

@interface WUClassifyCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WUClassifyCell

+ (instancetype)classifyCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WUClassifyCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)updateUIWithModel:(WUClassifyModel *)model {
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.titleLabel.text = model.name;
}

@end
